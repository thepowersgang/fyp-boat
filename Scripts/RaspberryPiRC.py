# 
# Script that turns joystick inputs into PWM on the GPIO
#
#
# Dependencies:
# - RPIO
# - 
# $ sudo apt-get install python-setuptools
# $ sudo easy_install -U RPIO
import RPIO
import joystick

def main():
	js = joystick.Joystick('/dev/input/js0')
	for u in js.peek_updates():
		print u
	pass


if __name__ == "__main__":
	main()

# vim: ts=4 sw=4

