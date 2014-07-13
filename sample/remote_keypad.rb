require "nunchuck/xinput/keypad"
require "xinput/remote"

port = "/dev/i2c-1"

keypad    = XInput::RemoteKeyboard.new "127.0.0.1"
nunchuck  = Nunchuck::KeyPad.new(port, keypad)

nunchuck.init()
nunchuck.poll()
