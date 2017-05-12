% Requirements for patching ArduPilot firmware

Notes
======

- We're using the AVR version of the source
 - [http://github.com/ArduPilot/ardupilot.git](Git Link), branch `master-AVR`
- Boats use the `APMrover2` tree

Adding new scheduled tasks
=========================

The ArduPilot firmware appears to be a soft-realtime system with a fixed list of tasks to run.
These tasks are defined in a list in `APMrover2.cpp`, and appears to be easy to add to.


Required Patches
================
- Hourly (configurable?) updates via sattelite modem
- External logging of position information (is this required, given there's an on-board logger?)
 - Internal logger is 16-megabit (2MB), probably not sufficient?
- Wifi serial port? (Likely that can be connected to the radio modem port)

Satellite modem
---------------

### Port Requirements
- 3x pins - Tx,Rx,Sleep

### Software
- [http://arduiniana.org/libraries/iridiumsbd/](IridiumSBD)
- Supports software serial, has callback-based mechanism
 - NOTE: Will need to call the scheduler from within this callback, to ensure continued operation of the system during transmission





Remote Telemetry Options
========================

Remote telemetry is needed, either by a 3G modem (suitable for initial testing close to land), or via Satellite modem.
Both of these links are bandwidth-constrained (the satellite far more so than the 3G), so require some form of limiting and batching.

Two major options for doing this bandwidth limiting: Custom telemetry/control logic on the APM board, or an external board doing proxying (and handling the different communiation forms).
- Proxy board is architectually simpler, but requires a second microcontroller board (more power drain)


3G Modem
---------

3G modem functionally acts as a serial bridge. Sending custom telemetry data over that isn't hard, but getting commands back is difficult.
Ideally, the 3G port would be able to inject MAVLink commands into the main MAVLink stream, but that isn't exceptionally simple. (It's doable, but runs into issues with getting ACKs back)

Existing MAVLink telemetry can't be turned to below 1Hz, so just passing that through isn't an option (and wouldn't work for the sattelite anyway)


MAVLink Bridging
----------------

MAVLink is well documented [http://ardupilot.org/dev/docs/mavlink-commands.html](Meta-link), and should be pretty easy to filter/bridge with an external board
- External board watches its serial port and caches the last telemetry update to send every `n` minutes.
- Passes through commands and replies to commands (and the next telemetry update?)


