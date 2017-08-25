
Required Patches
================

- 3G/Sattelite telemetry (Software serial on Input8/Output8)
  - Required
- Slower wifi telemtry
  - Easy and desired
- Battery sensing (ADC on one of the inputs)
  - Required
- Capsise detection
  - Nice
- Face waves mode
  - Nice

Slower Telemetry
--------
- Can be lowered to 1Hz in configuraiton. Should be sufficient.
- Should be able to be disabled by remote.

3G/Sattelite Telemetry
----------------------
Custom framing protocol with bulk updates, see `UpdatesAndControl.md`
- Should send a log of various trigger events (uptime, power loss, heavy waves, ...)


Battery Sensing
---------------
Input on an ADC channel. Determine if any ADC channels are already in use (and could be configured for a different ARef)
Should report the voltage in telemetry (ideally in the same way as the LiPo battery would)
Trigger a driving shutdown if voltage drops and start back up if voltage rises again.

Capsise detection
-----------------
If the gyro detects that the boat is upside down for more than `n` seconds, cut power and flag panic.
- Simple `if gyro_bank ~= 180 degrees, enter cap mode`

Heavy Waves
-----------
If the waves are detected to be large, turn the boat such that the oscilations are purely pitch.

- If bank is excessive, turn on the spot until bank is close to zero (increasing pitch)
- NOTE: Base bank on the steady-state value (if it's below a threshold)?




Detailed Notes: Battery Sensing
===============================
- Requires software serial (as none of the hardware UARTs are avaliable)
- This will need
	- A high-resolution timer (sufficient for at least $9600 * 2$ ticks per second). That rate is possibly too fast to be successfully done with just the existing timing support.
  - Edge-triggered interrupt (for RX, should be avaliable on the servo inputs)



