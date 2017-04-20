# 
# Script that turns joystick inputs into PWM on the GPIO
#
# To access GPIO, this script must be run as root (or via sudo)
# PIN ASSIGNMENTS:
# - GPIO 18 - Throttle
# - GPIO 17 - Steering
# - GPIO 23 - Mode (fixed)
# SEE: http://elinux.org/RPi_Low-level_peripherals#Model_A_and_B_.28Original.29

import RPi.GPIO as GPIO
import joystick
import sys

def main():
	GPIO.setmode(GPIO.BCM)

	FREQ = 50
	PULSE_MIN = 100 * 0.001 / (1.0 / FREQ)	# 1ms as a % of period
	PULSE_MAX = 100 * 0.002 / (1.0 / FREQ)	# 2ms as a % of period


	def signed_to_duty(v):
		assert -1.0 <= v and v <= 1.0
		return PULSE_MIN + (PULSE_MAX - PULSE_MIN) * (v + 1.0) / 2.0
	
	def pwm_pin(pin, init_val=0.0):
		GPIO.setup(pin, GPIO.OUT)
		rv = GPIO.PWM(pin, FREQ)
		rv.start(signed_to_duty(init_val))
		return rv
	
	# - Configure pins
	pin_throttle = pwm_pin(18)
	pin_steer    = pwm_pin(17)
	pin_mode     = pwm_pin(23)
	
	# Open the joystick and watch for updates
	js = joystick.Joystick('/dev/input/js0')
	for u in js.peek_updates():
		if u.name == "x":
			pass
		elif u.name == "y":
			pass
		elif u.name == "z":
			new_duty = signed_to_duty(u.value)
			print "STEER: %.2f       \r" % (new_duty,), ; sys.stdout.flush()
			pin_steer.ChangeDutyCycle( new_duty )
		elif u.name == "rz":
			new_duty = signed_to_duty(-u.value)
			print "THROTTLE: %.2f    \r" % (new_duty,), ; sys.stdout.flush()
			pin_throttle.ChangeDutyCycle( new_duty )
			pass
		else:
			print u
			continue
	pass

if __name__ == "__main__":
	main()

# vim: ts=4 sw=4

