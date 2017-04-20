# LIBRARY: Provides very basic interface to the linux joystick API
#
# This is a port of the sample at https://gist.github.com/rdb/8864666, published using "Unlicence" (Public Domain)
import array
import fcntl
import struct

JSIOCGNAME    = 0x80006a13	# NOTE: Buffer length encoded in bits 16:?24
JSIOCGAXES    = 0x80016a11
JSIOCGBUTTONS = 0x80016a12
JSIOCGAXMAP   = 0x80406a32	# Get list of axis names
JSIOCGBTNMAP  = 0x80406a34	# Get list of button names

class Joystick(object):
	def __init__(self, path):
		self._fd = open(path, 'rb')

		# Read name
		buf = array.array('c', ['\0'] * 64)
		fcntl.ioctl(self._fd, JSIOCGNAME + (len(buf) << 16), buf);
		self._name = buf.tostring()

		# Enumerate Axes
		buf = array.array('B', [0])
		fcntl.ioctl(self._fd, JSIOCGAXES, buf)
		count = buf[0]
		buf = array.array('B', [0] * 0x40)	# NOTE: I assume that 64 is what this ioctl requires
		fcntl.ioctl(self._fd, JSIOCGAXMAP, buf)
		self._axes = []
		self._axes_map = {}
		for name_idx in buf[0:count]:
			name = AXIS_NAMES.get(name_idx, 'unk(0x%02x)' % name_idx)
			self._axes_map[name] = len(self._axes)
			self._axes.append( Value(name, 0.0) )

	 	# Enumerate buttons
		buf = array.array('B', [0])
		fcntl.ioctl(self._fd, JSIOCGBUTTONS, buf)
		count = buf[0]
		buf = array.array('B', [0] * 200)	# NOTE: Is this a definition in the kernel?
		fcntl.ioctl(self._fd, JSIOCGBTNMAP, buf)
		self._buttons = []	# Array of button definitions (with previous values)
		self._buttons_map = {}	# Name->Index map
		for name_idx in buf[0:count]:
			name = BUTTON_NAMES.get(name_idx, 'unk(0x%02x)' % name_idx)
			self._buttons_map[name] = len(self._buttons)
			self._buttons.append( Value(name, False) )

	def peek_updates(self):
		while True:
			buf = self._fd.read(8)
			if not buf:
				return
			if len(buf) == 0:
				return
			assert len(buf) == 8
			
			(time, value, ty, idx) = struct.unpack('IhBB', buf)

			if ty & 0x80:
				# Initial value
				pass
			if ty & 0x1:
				# Button change
				v = self._buttons[idx]
				v.update(time, bool(value))
				yield Update(time, v.name, v.value)
			elif ty & 0x2:
				v = self._axes[idx]
				v.update(time, value / 32767.0)
				yield Update(time, v.name, v.value)
			else:
				pass
	
class Value(object):
	def __init__(self, name, default):
		self._name = name
		self._value = default
	@property
	def name(self):
		return self._name
	@property
	def value(self):
		return self._value

	def update(self, time, new_value):
		self._value = new_value
class Update(object):
	def __init__(self, time, name, new_value):
		self.time = time
		self.name = name
		self.value = new_value
	def __repr__(self):
		return "@%i %s=%r" % (self.time, self.name, self.value)

# These constants were borrowed from linux/input.h
AXIS_NAMES = {
    0x00 : 'x',
    0x01 : 'y',
    0x02 : 'z',
    0x03 : 'rx',
    0x04 : 'ry',
    0x05 : 'rz',
    0x06 : 'trottle',
    0x07 : 'rudder',
    0x08 : 'wheel',
    0x09 : 'gas',
    0x0a : 'brake',
    0x10 : 'hat0x',
    0x11 : 'hat0y',
    0x12 : 'hat1x',
    0x13 : 'hat1y',
    0x14 : 'hat2x',
    0x15 : 'hat2y',
    0x16 : 'hat3x',
    0x17 : 'hat3y',
    0x18 : 'pressure',
    0x19 : 'distance',
    0x1a : 'tilt_x',
    0x1b : 'tilt_y',
    0x1c : 'tool_width',
    0x20 : 'volume',
    0x28 : 'misc',
}

BUTTON_NAMES = {
    0x120 : 'trigger',
    0x121 : 'thumb',
    0x122 : 'thumb2',
    0x123 : 'top',
    0x124 : 'top2',
    0x125 : 'pinkie',
    0x126 : 'base',
    0x127 : 'base2',
    0x128 : 'base3',
    0x129 : 'base4',
    0x12a : 'base5',
    0x12b : 'base6',
    0x12f : 'dead',
    0x130 : 'a',
    0x131 : 'b',
    0x132 : 'c',
    0x133 : 'x',
    0x134 : 'y',
    0x135 : 'z',
    0x136 : 'tl',
    0x137 : 'tr',
    0x138 : 'tl2',
    0x139 : 'tr2',
    0x13a : 'select',
    0x13b : 'start',
    0x13c : 'mode',
    0x13d : 'thumbl',
    0x13e : 'thumbr',

    0x220 : 'dpad_up',
    0x221 : 'dpad_down',
    0x222 : 'dpad_left',
    0x223 : 'dpad_right',

    # XBox 360 controller uses these codes.
    0x2c0 : 'dpad_left',
    0x2c1 : 'dpad_right',
    0x2c2 : 'dpad_up',
    0x2c3 : 'dpad_down',
}

# vim: ts=4

