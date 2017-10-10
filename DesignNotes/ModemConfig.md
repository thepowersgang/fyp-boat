
Modem Configuration
-------------------

Supports two "modes":
- Standard 3G modem
- Serial forwarding.


Modem supports dynamic DNS and can be a TCP server - best option.


Command sequence to initialise:
- `AT+SERIAL_BAUD=57600`	(Set baud rate for when in PAD=1 mode)
- `AT+SERVER=motsugo.ucc.asn.au,1516`	(Set TCP target host, default value)
- `AT+SMS_PASSWORD=<removed>`	(Set SMS diagnostics password)
- `AT+SMS_DIAGNOSTICS=1`	(Enable SMS diagnostics)
- `AT+SMS_ACK=0`	(Disable ACK SMS messages)
- `AT+PAD=1`	(TCP Client)
NOTE: After the `AT+PAD` command, the modem will be in TCP mode until `+++` is seen on the line (unknown if a timeout is needed after the `+++`)

This configuration should only need to be done once, after which the modem will boot back into the TCP server mode




Data Formats
------------

Ideally, just MAVLink should work, but it doesn't appear to have built-in auto-framing (i.e. if you get just half of a message, you lose the entire stream with no way to resync)

To avoid this, COBS can be used (which encodes a message such that NUL always terminates a message, and interior NULs are handled with byte counts)

Alternative is to use timeout-based resynch.

