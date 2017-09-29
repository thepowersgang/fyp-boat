extern crate byteorder;
extern crate serial;
extern crate crc16;

use byteorder::{ReadBytesExt,LittleEndian};
use std::io;
use std::io::{Read};

static MAVLINK_MESSAGE_CRCS: [u8; 256] =[
  	50,124,137,0,237,217,104,119,0,0,0,89,0,0,0,0,0,0,0,0,214,159,220,168,
	24,23,170,144,67,115,39,246,185,104,237,244,222,212,9,254,230,28,28,
	132,221,232,11,153,41,39,214,223,141,33,15,3,100,24,239,238,30,240,183,
	130,130,0,148,21,0,243,124,0,0,0,20,0,152,143,0,0,127,106,0,0,0,0,0,0,
	0,231,183,63,54,0,0,0,0,0,0,0,175,102,158,208,56,93,0,0,0,0,235,93,124,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,42,
	241,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,204,49,
	170,44,83,46,0];


fn main()
{
	let mut stream = ::serial::open("/dev/ttyUSB0").expect("Open");
	//let mut stream = ::serial::open("/dev/ttyACM0").expect("Open");
	::serial::SerialPort::configure(&mut stream, &::serial::PortSettings {
		//baud_rate: ::serial::Baud115200,
		baud_rate: ::serial::Baud57600,
		char_size: ::serial::Bits8,
		parity: ::serial::ParityNone,
		stop_bits: ::serial::Stop1,
		flow_control: ::serial::FlowNone,
		});

	{
		let mut nbytes = 0;
		loop
		{
			match stream.read_u8()
			{
			Ok(_) => {
				nbytes += 1;
				},
			Err(ref e) if e.kind() == io::ErrorKind::TimedOut => break,
			Err(e) => panic!("{:?}", e),
			}
		}
		println!("Consumed {} bytes before timeout", nbytes);
	}
	loop
	{
		let f = match Header::read(&mut stream)
			{
			Err(ref e) if e.kind() == io::ErrorKind::TimedOut => continue,
			Err(e) => {
				println!("Read header: {:?}", e);
				continue
				},
			Ok(Some(f)) => f,
			Ok(None) => panic!(""),
			};

		let mut data_buf = [0; 255];
		let data = &mut data_buf[.. f.len as usize];
		stream.read_exact(data).expect("Read data");
		let crc = stream.read_u16::<LittleEndian>().unwrap();

		let mut crc_state = ::crc16::State::<::crc16::X_25>::new();
		crc_state.update(&[/*f.magic,*/ f.len, f.seq, f.src_sys, f.src_comp, f.msg_id]);
		crc_state.update(data);
		crc_state.update(&[MAVLINK_MESSAGE_CRCS[f.msg_id as usize]]);

		println!("{:?} 0x{:04x}=={:04x}", f, crc, crc_state.get());
	}
}

struct Header
{
	_magic: u8,
	len: u8,
	seq: u8,
	src_sys: u8,
	src_comp: u8,
	msg_id: u8,
}
impl ::std::fmt::Debug for Header {
	fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
		write!(f, "{:3}: 0x{:02x} from {}/{} {:2} bytes", self.seq, self.msg_id, self.src_sys, self.src_comp, self.len)
	}
}
impl Header
{
	fn read<R: io::Read>(mut s: R) -> io::Result<Option<Header>>
	{
		let magic = s.read_u8()?;
		if magic != 0xFE {
			println!("Bad STX {:02x}", magic);
			return Ok(None);
		}
		Ok(Some(Header {
			_magic: magic,
			len: s.read_u8()?,
			seq: s.read_u8()?,
			src_sys: s.read_u8()?,
			src_comp: s.read_u8()?,
			msg_id: s.read_u8()?,
			}))
	}
}

