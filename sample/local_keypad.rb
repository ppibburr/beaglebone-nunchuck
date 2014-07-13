require "nunchuck/xinput/keypad"
require "xinput/local"

port = "/dev/i2c-1"

keypad    = XInput::LocalKeyboard.new "127.0.0.1"
nunchuck  = Nunchuck::KeyPad.new(port, keypad)

nunchuck.init()
nunchuck.poll()
