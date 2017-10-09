extern crate tokio_core;
extern crate tokio_io;
extern crate tokio_proto;
extern crate futures;
extern crate crc16;
extern crate byteorder;
#[macro_use]
extern crate log;

use tokio_io::{AsyncRead/*,AsyncWrite*/};
use futures::{Future,Async};
use futures::Stream;
use std::io::{Cursor,Write};
use std::sync::{Mutex,Arc};

mod mavlink;

fn main()
{
    // A cache of messages received from the boat
    let cache = Arc::new(MessageCache {
        cached_messages: Default::default(),
        to_boat_messages: Default::default(),
        log: Mutex::new(::std::fs::File::create("boat_log.log").expect("Opening boat logfile")),
        });

    let mut core = ::tokio_core::reactor::Core::new().expect("Core::new");
    let handle = core.handle();

    let boat_server = ::tokio_core::net::TcpListener::bind(&"0.0.0.0:1516".parse().unwrap(), &handle).unwrap();

    let boat_server = boat_server.incoming().for_each(|(sock, addr)| {
        info!("Boat connection from {}", addr);
        let (reader, mut writer) = sock.split();
        // Start read task on this socket
        // TODO: Push messages from the GCS to the boat
        let read_stream = {
            let cache = cache.clone();
            MavlinkSocket::new(reader, &handle)
                .map(move |v| {
                    // Hand this message off to the caching layer
                    debug!("{:?}", v);
                    cache.push_to_gcs(v);
                    })
                .map_err(|e| println!("ERROR: {:?}", e))
                .for_each(|_| Ok( () ))
            };
        let write_stream = cache.stream_to_boat()
            .map(move |msg| {
                let _ = writer.write(&msg.to_vec());
                })
            .map_err(|e| println!("ERROR: {:?}", e))
            .for_each(|_| Ok( () ))
            ;
        handle.spawn(read_stream);
        handle.spawn(write_stream);
        Ok( () )
        });

    let gcs_server = ::tokio_core::net::TcpListener::bind(&"0.0.0.0:1517".parse().unwrap(), &handle).unwrap();
    let gcs_server = gcs_server.incoming().for_each(|(sock, addr)| {
        info!("GCS connection from {}", addr);
        let (reader, mut writer) = sock.split();
        let read_stream = {
            let cache = cache.clone();
            MavlinkSocket::new(reader, &handle)
                .map(move |v| {
                    debug!("GCS-> {:?}", v);
                    // Store this message for transmission to the boat
                    cache.push_to_boat(v);
                    })
                .map_err(|e| println!("ERROR: {:?}", e))
                .for_each(|_| Ok( () ))
            };
        let write_stream = cache.stream_to_gcs()
            .map(move |msg| {
                let _ = writer.write(&msg.to_vec());
                })
            .map_err(|e| println!("ERROR: {:?}", e))
            .for_each(|_| Ok( () ))
            ;
        handle.spawn(read_stream);
        handle.spawn(write_stream);
        Ok( () )
        });
    
    core.run(Future::join(boat_server, gcs_server)).unwrap();
}

type MsgQueue = Arc<Mutex<::std::collections::VecDeque<MavLinkMessage>>>;
struct MessageCache
{
    // Messages to be echoed to every client (when updated or on connection)
    cached_messages: Arc<Mutex<MessageList>>,
    to_boat_messages: MsgQueue,

    log: Mutex<::std::fs::File>,
}
#[derive(Default)]
struct MessageList
{
    index: usize,
    messages: ::std::collections::HashMap<u8,MavLinkMessage>,
}

impl MessageCache
{
    fn push_to_gcs(&self, message: MavLinkMessage)
    {
        match message.id
        {
        // MAVLINK_MSG_ID_GLOBAL_POSITION_INT - Current GPS coords as integers
        // - Cache raw message, record decoded
        33 => { 
            let msg = mavlink::GlobalPositionInt::decode(message.get_data());
            let _ = writeln!(self.log.lock().unwrap(), "[{}] {:?}", message.src.0, msg);
            self.cached_messages.lock().unwrap().update(33, message);
            },
        _ => {},
        }
    }
    fn stream_to_gcs(&self) -> Box<::futures::Stream<Item=MavLinkMessage,Error=::std::io::Error>>
    {
        struct S(Arc<Mutex<MessageList>>, usize);
        impl Stream for S {
            type Item = MavLinkMessage;
            type Error = ();
            fn poll(&mut self) -> ::futures::Poll<Option<MavLinkMessage>,Self::Error>
            {
                let mut lh = self.0.lock().unwrap();
                if lh.index != self.1 {
                    self.1 += 1;
                    Ok(Async::Ready(Some( lh.pop_front().unwrap() )))
                }
                else {
                    Ok(Async::NotReady)
                }
            }
        }
        Box::new( S(self.to_boat_messages.clone()) )
        panic!("");
    }

    fn push_to_boat(&self, message: MavLinkMessage)
    {
        self.to_boat_messages.lock().unwrap().push_back(message);
    }
    //fn stream_to_boat(&self) -> impl ::futures::Stream<Item=MavLinkMessage,Error=()>
    fn stream_to_boat(&self) -> Box<::futures::Stream<Item=MavLinkMessage,Error=()>>
    {
        struct S(MsgQueue);
        impl Stream for S {
            type Item = MavLinkMessage;
            type Error = ();
            fn poll(&mut self) -> ::futures::Poll<Option<MavLinkMessage>,Self::Error>
            {
                let mut lh = self.0.lock().unwrap();
                if lh.is_empty() {
                    Ok(Async::Ready(Some( lh.pop_front().unwrap() )))
                }
                else {
                    Ok(Async::NotReady)
                }
            }
        }
        Box::new( S(self.to_boat_messages.clone()) )
    }
}
impl MessageList
{
    fn update(&mut self, id: u8, message: MavLinkMessage)
    {
        self.index += 1;
        self.messages.insert(id, message);
    }
}

/*
#[derive(Default)]
struct MavlinkCodec

impl ::tokio_core::io::Codec for MavlinkCodec
{
    type In = MavLinkMessage;
    type Out = MavLinkMessage;

    fn decode(&mut self, buf: &mut ::tokio_core::io::EasyBuf) -> Result<Option<MavLinkMessage>, io::Error> {
        assert(buf.len() > 0);
        if buf.as_slice()[0] != 0xFE {
            // Wait for timeout
        }
        else {
            if buf.len() < 6 {
                return Ok(None);
            }
            let msg_len = buf.as_slice()[1] as usize;
            if buf.len() < 6 + msg_len + 2 {
                return Ok(None);
            }

            let data = buf.drain_to(6 + msg_len + 2);

            Ok(Some(MavLinkMessage::parse(&data[..6], &data[6..][..msg_len], &data[6+msg_len..])))
        }
    }
}
*/

struct MavlinkSocket<S>
{
    socket: S,
    timeout: ::tokio_core::reactor::Timeout,
    state: MavLinkState,
    // Magic, Len, Seq, Sys, Comp, MsgId
    header_buf: [u8; 6],
    data_buf: [u8; 255],
    crc_buf: [u8; 2],
}
enum MavLinkState
{
    Header(usize),
    Data(usize, usize),
    Crc(usize),
}

impl<S> MavlinkSocket<S>
{
    fn new(socket: S, handle: &::tokio_core::reactor::Handle) -> Self
    {
        MavlinkSocket {
            socket: socket,
            timeout: ::tokio_core::reactor::Timeout::new(::std::time::Duration::new(1,0), handle).unwrap(),
            state: MavLinkState::Header(0),
            header_buf: [0; 6],
            data_buf: [0; 255],
            crc_buf: [0; 2],
            }
    }

    fn reset_timeout(&mut self)
    {
        self.timeout.reset(::std::time::Instant::now() + ::std::time::Duration::new(0,100_000)); // 100ms
    }
    fn check_timeout(&mut self) -> ::std::io::Result<bool>
    {
        Ok(self.timeout.poll()?.is_ready())
    }
}
impl<S> ::futures::Stream for MavlinkSocket<S>
where
    S: ::tokio_io::AsyncRead
{ 
    type Item = MavLinkMessage;
    type Error = ::std::io::Error;
    fn poll(&mut self) -> ::futures::Poll<Option<MavLinkMessage>,::std::io::Error>
    {
        let mut complete = false;
        let ns = match self.state
            {
            MavLinkState::Header(ofs) => {
                if ofs == 0 {
                    self.reset_timeout();
                }
                match self.socket.read_buf(&mut Cursor::new(&mut self.header_buf[ofs..]))?
                {
                Async::NotReady => if ofs > 0 && self.check_timeout()? {
                        // TODO: Error?
                        Some(MavLinkState::Header(0))
                    }
                    else {
                        return Ok(Async::NotReady)
                    },
                Async::Ready(n) =>
                    if self.header_buf[0] != 0xFE {
                        // TODO: Error?
                        Some(MavLinkState::Header(0))
                    }
                    else if ofs+n < 6 {
                        Some(MavLinkState::Header(ofs+n))
                    }
                    else {
                        assert_eq!(ofs+n, 6);
                        Some(MavLinkState::Data( 0, self.header_buf[1] as usize ))
                    }
                }
                },
            MavLinkState::Data(ofs, count) =>
                match self.socket.read_buf(&mut Cursor::new(&mut self.data_buf[ofs..count]))?
                {
                Async::NotReady => if self.check_timeout()? {
                        // TODO: Error?
                        Some(MavLinkState::Header(0))
                    }
                    else {
                        return Ok(Async::NotReady)
                    },
                Async::Ready(n) =>
                    if ofs+n < count {
                        Some(MavLinkState::Data(ofs+n, count))
                    }
                    else {
                        Some(MavLinkState::Crc(0))
                    }
                },
            MavLinkState::Crc(ofs) =>
                match self.socket.read_buf(&mut Cursor::new(&mut self.crc_buf[ofs..]))?
                {
                Async::NotReady => if self.check_timeout()? {
                        // TODO: Error?
                        Some(MavLinkState::Header(0))
                    }
                    else {
                        return Ok(Async::NotReady)
                    },
                Async::Ready(n) =>
                    if ofs+n < 2 {
                        Some(MavLinkState::Crc(ofs+n))
                    }
                    else {
                        complete = true;
                        Some(MavLinkState::Header(0))
                    }
                }
            };
        if let Some(s) = ns
        {
            self.state = s;
        }

        if complete
        {
            let msg = MavLinkMessage::parse(&self.header_buf, &self.data_buf, &self.crc_buf);
            Ok(Async::Ready(Some(msg)))
        }
        else
        {
            Ok(Async::NotReady)
        }
    }
}

struct MavLinkMessage
{
    valid: bool,
    id: u8,
    seq: u8,
    src: (u8, u8),
    len: u8,
    crc: u16,
    data_buf: [u8; 255],
}
impl MavLinkMessage
{
    fn parse(header: &[u8; 6], data: &[u8; 255], crc_bytes: &[u8; 2]) -> MavLinkMessage
    {
        let rv = MavLinkMessage {
            valid: header[0] == 0xFE,
            id: header[5],
            src: (header[3], header[4]),
            seq: header[2],
            len: header[1],
            crc: (crc_bytes[1] as u16) << 8 + crc_bytes[0] as u16,
            data_buf: *data,
            };

		let mut crc_state = ::crc16::State::<::crc16::X_25>::new();
		crc_state.update(&header[1..]);
		crc_state.update(&data[..rv.len as usize]);
		//crc_state.update(&[MAVLINK_MESSAGE_CRCS[rv.id as usize]]);
        //if crc_state.get() != crc_bytes[1] as u16 * 256 + crc_bytes[0] as u16 {
        //    rv.valid = false;
        //}

        rv
    }

    fn get_data(&self) -> &[u8] {
        &self.data_buf[..self.len as usize]
    }

    fn to_vec(&self) -> Vec<u8>
    {
        let mut rv = Vec::with_capacity(6 + self.len as usize + 2);
        rv.push(0xFE);
        rv.push(self.len);
        rv.push(self.seq);
        rv.push(self.src.0);
        rv.push(self.src.1);
        rv.push(self.id);
        rv.extend(self.get_data());
        rv.push(self.crc as u8);
        rv.push((self.crc >> 8) as u8);
        rv
    }
}
impl ::std::fmt::Debug for MavLinkMessage
{
    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result
    {
        if !self.valid {
            write!(f, "INVALID:")?;
        }
        write!(f, "{:02x} {:3} {} bytes", self.id, self.seq, self.len)?;
        Ok( () )
    }
}

