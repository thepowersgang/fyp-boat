//
//
//
extern crate byteorder;
extern crate crc16;
extern crate env_logger;
#[macro_use]
extern crate log;
extern crate chrono;	// timestamps
extern crate mavlink;	// used for message definitions

use byteorder::{ReadBytesExt,LittleEndian};
use std::io;
use std::io::{Read};

static MAVLINK_MESSAGE_CRCS: [u8; 256] =[
	//0   1    2    3    4    5    6    7     8    9    a    b    c    d    e    f
  	 50, 124, 137,   0, 237, 217, 104, 119,    0,   0,   0,  89,   0,   0,   0,   0,	// 0_
	  0,   0,   0,   0, 214, 159, 220, 168,   24,  23, 170, 144,  67, 115,  39, 246,	// 1_
	185, 104, 237, 244, 222, 212,   9, 254,  230,  28,  28, 132, 221, 232,  11, 153,	// 2_
	 41,  39, 214, 223, 141,  33,  15,   3,  100,  24, 239, 238,  30, 240, 183,	130,	// 3_
	130,   0, 148,  21,   0, 243, 124,   0,    0,   0,  20,   0, 152, 143,   0,   0,	// 4_
	127, 106,   0,   0,   0,   0,   0,   0,    0, 231, 183,  63,  54,   0,   0,   0,	// 5_
	  0,   0,   0,   0, 175, 102, 158, 208,   56,  93,   0,   0,   0,   0, 235,  93,	// 6_
	124,   0,   0,   0,   0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// 7_
	  0,   0,   0,   0,   0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// 8_
	  0,   0,   0,  42, 241,  15,   0,   0,  208,   0,   0,   0,   0,   0,   0,   0,	// 9_
	  0,   0,   0, 127,   0,  21,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// A_
	  0,   0,   0,   0,   0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// B_
	  0,   0,   0,   0,   0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// C_
	  0,   0,   0,   0,   0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// D_
	  0,   0,   0,   0,   0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,	// E_
	  0,   0,   0,   0,   0,   0,   0,   0,    0, 204,  49, 170,  44,  83,  46,   0,	// F_
	];


fn main()
{
	::env_logger::LogBuilder::new()
		.format(|record| format!("{} {} - {}", ::chrono::Local::now().format("%F %T%.3f"), record.level(), record.args()))
		.filter(None, ::log::LogLevelFilter::Info)
		.parse(&::std::env::var("RUST_LOG").unwrap_or(String::new()))
		.init();

	let listen_addr = "[::]:1516";
	let server = match ::std::net::TcpListener::bind(listen_addr)
		{
		Ok(v) => v,
		Err(e) => {
			error!("Cannot open server on '{}' - {}", listen_addr, e);
			return ;
			},
		};

	info!("SERVER STARTED on '{}'", listen_addr);
	while let Ok( (stream, addr) ) = server.accept()
	{
		info!("Connection from {}", addr);
		handle_client(stream);
	}
}
	
fn handle_client(mut stream: ::std::net::TcpStream)
{
	if false
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
			Err(e) => {
				error!("Error doing initial read {:?}, dropping connection", e);
				return ;
				}
			}
		}
		info!("Consumed {} bytes before timeout", nbytes);
	}
	let start_time = ::std::time::Instant::now();
	let mut last_time = ::std::time::Instant::now();
	loop
	{
		let f = match Header::read(&mut stream)
			{
			Err(ref e) if e.kind() == io::ErrorKind::TimedOut => continue,
			Err(ref e) if e.kind() == io::ErrorKind::UnexpectedEof => {
				info!("Client disconnected");
				return;
				},
			Err(e) => {
				error!("Error reading header - {}, trying again", e);
				continue
				},
			Ok(Some(f)) => f,
			Ok(None) => {
				println!("Malformed packet");
				continue
				},
			};

		let mut data_buf = [0; 255];
		let data = &mut data_buf[.. f.len as usize];
		if let Err(e) = stream.read_exact(data)
		{
			error!("Error reading data - {}, closing connection", e);
			return ;
		}
		let crc = stream.read_u16::<LittleEndian>().unwrap();

		//let mut crc_state = ::crc16::State::<::crc16::X_25>::new();
		let mut crc_state = ::crc16::State::<::crc16::MCRF4XX>::new();
		crc_state.update(&[/*f.magic,*/ f.len, f.seq, f.src_sys, f.src_comp, f.msg_id]);
		crc_state.update(data);
		crc_state.update(&[MAVLINK_MESSAGE_CRCS[f.msg_id as usize]]);

		if crc != crc_state.get() {
			error!("Message CRC mismatch - {:?} 0x{:04x} != 0x{:04x} ", f, crc, crc_state.get());
			continue ;
		}

		print!("{:.3} d={:.3}, {:?} ", d_float(start_time.elapsed()), d_float(last_time.elapsed()), f);
		match f.msg_id
		{
		  0 => {
			let p: ::mavlink::common::HEARTBEAT_DATA = ::mavlink::common::Parsable::parse(data);
			println!("{:?}", p);

			info!("HEARTBEAT mode={}",
				match p.custom_mode {
				0 => "MANUAL",
				2 => "LEARNING",
				3 => "STEERING",
				4 => "HOLD",
				10 => "AUTO",
				11 => "RTL",
				15 => "GUIDED",
				16 => "INITIALISING",
				_ => "?",
				}
				);
			},
		  1 => {
			let p: ::mavlink::common::SYS_STATUS_DATA = ::mavlink::common::Parsable::parse(data);
			println!("{:?}", p);
			info!("SYS_STATUS cpu_load={}% battery_v={}mV battery={}%",
				p.load/10, p.voltage_battery, p.battery_remaining
				);
		  	},
		  2 => println!("SYSTEM_TIME"),
		  4 => println!("PING"),
		  5 => println!("CHANGE_OPERATOR_CONTROL"),
		  6 => println!("CHANGE_OPERATOR_CONTROL_ACK"),
		  7 => println!("AUTH_KEY"),
		 11 => println!("SET_MODE"),
		 20 => println!("PARAM_REQUEST_READ"),
		 21 => println!("PARAM_REQUEST_LIST"),
		 22 => println!("PARAM_VALUE"),
		 23 => println!("PARAM_SET"),
		 24 => println!("GPS_RAW_INT"),
		 25 => println!("GPS_STATUS"),
		 26 => println!("SCALED_IMU"),
		 27 => println!("RAW_IMU"),
		 28 => println!("RAW_PRESSURE"),
		 29 => println!("SCALED_PRESSURE"),
		 30 => println!("ATTITUDE"),
		 31 => println!("ATTITUDE_QUATERNION"),
		 32 => println!("LOCAL_POSITION_NED"),
		 33 => {
			let p: ::mavlink::common::GLOBAL_POSITION_INT_DATA = ::mavlink::common::Parsable::parse(data);
			println!("{:?}", p);

			info!("GLOBAL_POSITION_INT t={}ms lat={:.7} lon={:.7} alt={:.3} vx={}cms vy={}cms",
				p.time_boot_ms,
				p.lat as f64 / 1e7,
				p.lon as f64 / 1e7,
				p.alt as f64 / 1e3,
				p.vx,
				p.vy,
				);
		 	},
		 34 => println!("RC_CHANNELS_SCALED"),
		 35 => println!("RC_CHANNELS_RAW"),
		 36 => println!("SERVO_OUTPUT_RAW"),
		 37 => println!("MISSION_REQUEST_PARTIAL_LIST"),
		 38 => println!("MISSION_WRITE_PARTIAL_LIST"),
		 39 => println!("MISSION_ITEM"),
		 40 => println!("MISSION_REQUEST"),
		 41 => println!("MISSION_SET_CURRENT"),
		 42 => println!("MISSION_CURRENT"),
		 43 => println!("MISSION_REQUEST_LIST"),
		 44 => println!("MISSION_COUNT"),
		 45 => println!("MISSION_CLEAR_ALL"),
		 46 => println!("MISSION_ITEM_REACHED"),
		 47 => println!("MISSION_ACK"),
		 48 => println!("SET_GPS_GLOBAL_ORIGIN"),
		 49 => println!("GPS_GLOBAL_ORIGIN"),
		 50 => println!("PARAM_MAP_RC"),
		 54 => println!("SAFETY_SET_ALLOWED_AREA"),
		 55 => println!("SAFETY_ALLOWED_AREA"),
		 61 => println!("ATTITUDE_QUATERNION_COV"),
		 62 => println!("NAV_CONTROLLER_OUTPUT"),
		 63 => println!("GLOBAL_POSITION_INT_COV"),
		 64 => println!("LOCAL_POSITION_NED_COV"),
		 65 => println!("RC_CHANNELS"),
		 66 => println!("REQUEST_DATA_STREAM"),
		 67 => println!("DATA_STREAM"),
		 69 => println!("MANUAL_CONTROL"),
		 70 => println!("RC_CHANNELS_OVERRIDE"),
		 73 => println!("MISSION_ITEM_INT"),
		 74 => println!("VFR_HUD"),
		 75 => println!("COMMAND_INT"),
		 76 => println!("COMMAND_LONG"),
		 77 => println!("COMMAND_ACK"),
		 81 => println!("MANUAL_SETPOINT"),
		 82 => println!("SET_ATTITUDE_TARGET"),
		 83 => println!("ATTITUDE_TARGET"),
		 84 => println!("SET_POSITION_TARGET_LOCAL_NED"),
		 85 => println!("POSITION_TARGET_LOCAL_NED"),
		 86 => println!("SET_POSITION_TARGET_GLOBAL_INT"),
		 87 => println!("POSITION_TARGET_GLOBAL_INT"),
		 89 => println!("LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET"),
		 90 => println!("HIL_STATE"),
		 91 => println!("HIL_CONTROLS"),
		 92 => println!("HIL_RC_INPUTS_RAW"),
		100 => println!("OPTICAL_FLOW"),
		101 => println!("GLOBAL_VISION_POSITION_ESTIMATE"),
		102 => println!("VISION_POSITION_ESTIMATE"),
		103 => println!("VISION_SPEED_ESTIMATE"),
		104 => println!("VICON_POSITION_ESTIMATE"),
		105 => println!("HIGHRES_IMU"),
		106 => println!("OPTICAL_FLOW_RAD"),
		107 => println!("HIL_SENSOR"),
		108 => println!("SIM_STATE"),
		109 => println!("RADIO_STATUS"),
		110 => println!("FILE_TRANSFER_PROTOCOL"),
		111 => println!("TIMESYNC"),
		113 => println!("HIL_GPS"),
		114 => println!("HIL_OPTICAL_FLOW"),
		115 => println!("HIL_STATE_QUATERNION"),
		116 => println!("SCALED_IMU2"),
		117 => println!("LOG_REQUEST_LIST"),
		118 => println!("LOG_ENTRY"),
		119 => println!("LOG_REQUEST_DATA"),
		120 => println!("LOG_DATA"),
		121 => println!("LOG_ERASE"),
		122 => println!("LOG_REQUEST_END"),
		123 => println!("GPS_INJECT_DATA"),
		124 => println!("GPS2_RAW"),
		125 => println!("POWER_STATUS"),
		126 => println!("SERIAL_CONTROL"),
		127 => println!("GPS_RTK"),
		128 => println!("GPS2_RTK"),
		129 => println!("SCALED_IMU3"),
		130 => println!("DATA_TRANSMISSION_HANDSHAKE"),
		131 => println!("ENCAPSULATED_DATA"),
		132 => println!("DISTANCE_SENSOR"),
		133 => println!("TERRAIN_REQUEST"),
		134 => println!("TERRAIN_DATA"),
		135 => println!("TERRAIN_CHECK"),
		136 => println!("TERRAIN_REPORT"),
		137 => println!("SCALED_PRESSURE2"),
		138 => println!("ATT_POS_MOCAP"),
		139 => println!("SET_ACTUATOR_CONTROL_TARGET"),
		140 => println!("ACTUATOR_CONTROL_TARGET"),
		147 => println!("BATTERY_STATUS"),
		148 => println!("AUTOPILOT_VERSION"),
		149 => println!("LANDING_TARGET"),
		150 => println!("SENSOR_OFFSETS"),
		151 => println!("SET_MAG_OFFSETS"),
		152 => println!("MEMINFO"),
		153 => println!("AP_ADC"),
		154 => println!("DIGICAM_CONFIGURE"),
		155 => println!("DIGICAM_CONTROL"),
		156 => println!("MOUNT_CONFIGURE"),
		157 => println!("MOUNT_CONTROL"),
		158 => println!("MOUNT_STATUS"),
		160 => println!("FENCE_POINT"),
		161 => println!("FENCE_FETCH_POINT"),
		162 => println!("FENCE_STATUS"),
		163 => println!("AHRS"),
		164 => println!("SIMSTATE"),
		165 => println!("HWSTATUS"),
		166 => println!("RADIO"),
		167 => println!("LIMITS_STATUS"),
		168 => println!("WIND"),
		169 => println!("DATA16"),
		170 => println!("DATA32"),
		171 => println!("DATA64"),
		172 => println!("DATA96"),
		173 => println!("RANGEFINDER"),
		174 => println!("AIRSPEED_AUTOCAL"),
		175 => println!("RALLY_POINT"),
		176 => println!("RALLY_FETCH_POINT"),
		177 => println!("COMPASSMOT_STATUS"),
		178 => println!("AHRS2"),
		179 => println!("CAMERA_STATUS"),
		180 => println!("CAMERA_FEEDBACK"),
		181 => println!("BATTERY2"),
		182 => println!("AHRS3"),
		183 => println!("AUTOPILOT_VERSION_REQUEST"),
		186 => println!("LED_CONTROL"),
		191 => println!("MAG_CAL_PROGRESS"),
		192 => println!("MAG_CAL_REPORT"),
		193 => println!("EKF_STATUS_REPORT"),
		194 => println!("PID_TUNING"),
		200 => println!("GIMBAL_REPORT"),
		201 => println!("GIMBAL_CONTROL"),
		202 => println!("GIMBAL_RESET"),
		203 => println!("GIMBAL_AXIS_CALIBRATION_PROGRESS"),
		204 => println!("GIMBAL_SET_HOME_OFFSETS"),
		205 => println!("GIMBAL_HOME_OFFSET_CALIBRATION_RESULT"),
		206 => println!("GIMBAL_SET_FACTORY_PARAMETERS"),
		207 => println!("GIMBAL_FACTORY_PARAMETERS_LOADED"),
		208 => println!("GIMBAL_ERASE_FIRMWARE_AND_CONFIG"),
		209 => println!("GIMBAL_PERFORM_FACTORY_TESTS"),
		210 => println!("GIMBAL_REPORT_FACTORY_TESTS_PROGRESS"),
		211 => println!("GIMBAL_REQUEST_AXIS_CALIBRATION_STATUS"),
		212 => println!("GIMBAL_REPORT_AXIS_CALIBRATION_STATUS"),
		213 => println!("GIMBAL_REQUEST_AXIS_CALIBRATION"),
		215 => println!("GOPRO_HEARTBEAT"),
		216 => println!("GOPRO_GET_REQUEST"),
		217 => println!("GOPRO_GET_RESPONSE"),
		218 => println!("GOPRO_SET_REQUEST"),
		219 => println!("GOPRO_SET_RESPONSE"),
		226 => println!("RPM"),
		241 => println!("VIBRATION"),
		248 => println!("V2_EXTENSION"),
		249 => println!("MEMORY_VECT"),
		250 => println!("DEBUG_VECT"),
		251 => println!("NAMED_VALUE_FLOAT"),
		252 => println!("NAMED_VALUE_INT"),
		253 => println!("STATUSTEXT {:?}", String::from_utf8_lossy(&data[..data.iter().position(|&x| x==0).unwrap_or(0)])),
		254 => println!("DEBUG"),
		255 => println!("EXTENDED_MESSAGE"),
		_ => println!("UNK"),
		}
		last_time = ::std::time::Instant::now();
	}
}
fn d_float(d: ::std::time::Duration)->f64 {
	d.as_secs() as f64 + (d.subsec_nanos() as f64 * 1e-9)
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
		write!(f, "{:3}: 0x{:02x} from {:2}/{:2} {:2} bytes", self.seq, self.msg_id, self.src_sys, self.src_comp, self.len)
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

