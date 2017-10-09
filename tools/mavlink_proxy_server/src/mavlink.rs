use byteorder::{LittleEndian,ReadBytesExt};

#[derive(Debug)]
pub struct GlobalPositionInt
{
    ///< Timestamp (milliseconds since system boot)
    time_boot_ms: u32,
    ///< Latitude, expressed as * 1E7
    lat: i32,
    ///< Longitude, expressed as * 1E7
    lon: i32,
    ///< Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)
    alt: i32,
    ///< Altitude above ground in meters, expressed as * 1000 (millimeters)
    relative_alt: i32, 
    ///< Ground X Speed (Latitude), expressed as m/s * 100
    vx: i16, 
    ///< Ground Y Speed (Longitude), expressed as m/s * 100
    vy: i16, 
    ///< Ground Z Speed (Altitude), expressed as m/s * 100
    vz: i16, 
    ///< Compass heading in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
    hdg: u16, 
}
impl GlobalPositionInt
{
    pub fn decode(mut data: &[u8]) -> GlobalPositionInt
    {
        GlobalPositionInt {
            time_boot_ms: data.read_u32::<LittleEndian>().expect("time_boot_ms"),
            lat: data.read_i32::<LittleEndian>().expect("lat"),
            lon: data.read_i32::<LittleEndian>().expect("lon"),
            alt: data.read_i32::<LittleEndian>().expect("alt"),
            relative_alt: data.read_i32::<LittleEndian>().expect("relative_alt"),
            vx: data.read_i16::<LittleEndian>().expect("vx"),
            vy: data.read_i16::<LittleEndian>().expect("vy"),
            vz: data.read_i16::<LittleEndian>().expect("vz"),
            hdg: data.read_u16::<LittleEndian>().expect("hdg"),
            }
    }
}
