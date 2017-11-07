// Creates a socket, and accepts two connections on it
// Data is echoed between both connections

fn main()
{
    let listen_addr: ::std::net::SocketAddr = "[::]:1516".parse().unwrap();
    println!("Starting server lisening on {}", listen_addr);

    loop
    {
        let sock1 = ::std::net::TcpListener::bind(listen_addr).unwrap();
        let (mut sock_a,ip_a) = sock1.accept().unwrap();
        println!("Connection from {}", ip_a);
        let (mut sock_b,ip_b) = sock1.accept().unwrap();
        println!("Connection from {}, starting proxy", ip_b);

        // Make two threads, one for Rx and one for Tx
        {
            let mut sock_a = sock_a.try_clone().unwrap();
            let mut sock_b = sock_b.try_clone().unwrap();
            ::std::thread::spawn(move || ::std::io::copy(&mut sock_b, &mut sock_a));
        }
        ::std::io::copy(&mut sock_a, &mut sock_b);

        println!("EOF");
    }
}
