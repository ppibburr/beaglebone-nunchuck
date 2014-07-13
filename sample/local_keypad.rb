require "nunchuck/xinput/keypad"
require "xinput/local"

port = "/dev/i2c-1"

keypad    = XInput::LocalKeyboard.new
nunchuck  = Nunchuck::KeyPad.new(port, keypad)

nunchuck.init()
nunchuck.poll()
