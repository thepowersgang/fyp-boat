% Notes on protocol used for sending position updates and various control changes

Restrictions
------------

All mesages must fit in a single SBD (sattelite) message (apprximately 340 bytes on remote Tx, and 270 Rx), however smaller is better as it reduces modem active time (and hence power consumpsion), and messages are charged per byte.


Option 1: Send raw MAVLink (batched for sattelite updates)
-----------

### Upsides
- Can use the existing software with just a small proxy server (that repeats the last message and batches up replies/commands)
- Possibly can reuse existing protocol handling code
### Downsides
- May not be very space efficient
- Possibly more complex to reimplement in firmware


Option 2: Custom format
----------------------

### Upsides
- Tightly controlled message lengths
- Simpler code on transmitter/receiver (hopefully)
### Downsides
- Requires a custom viewer (or client-side conversion code)


Avaliable Code
==============

- `ardupilot-source/libraries/GCS_MAVLink/include/mavlink/v1.0/ardupilotmega`
  - Contains the MAVLink serialisation support
  - Dowside, it's tied to serial ports. (can't write to a buffer)
- Pre-written I-SBD driver (from earlier in the year)


Format overview
===============
All messages have a 16-bit CRC/checksum of all message data (format is whatever is avaiable, TODO)
Composite types are stored in little endian (least significant byte first)

Header
--------
| Type  | Name/Desc |
| ----- | --------- |
| `u8`  | Message Type |
| `u8`  | Message length (bytes, excl 4 byte header) |
| `u16` | Checksum |

Positions
----------
Positions are encoded as 1.0.23 bit fixed-point fractonal lattidude and longitude (sign bit, no whole component, 23 fractional bits), Giving a positional precision of about 2m



Responses / Updates
===============
- Periodic
 > GPS position
 > Control state
 > Battery levels
 > Current waypoint list


0x00: Periodic Update
---------------
| Type  | Name/Desc |
| ----- | --------- |
| `u8`  | Bitset: State, GPS Fix quality |
| `u8`  | Velocity (fixed 5.3) |
| `u24` | Lattitude (fixed 1.23) |
| `u24` | Longitude (fixed 1.23) |
| `u32` | Uptime (s) |
| `u16` | Motor Power Left (us) |
| `u16` | Motor Power Right (us) |
| `u16` | Battery voltage (raw ADC) |

Commands
========

Overview
--------
- State change (Navigate, Drift, Position hold, ...)
- Replace entire route
- Add waypoint to current route
- Delete waypoint from route
- Alter response freqency

0x80: New Route
---------


