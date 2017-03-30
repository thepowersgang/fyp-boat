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



