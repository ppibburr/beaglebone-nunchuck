require "nunchuck/xinput/mouse"
require "xinput/local"

port = "/dev/i2c-1"

mouse     = XInput::LocalMouse.new
nunchuck  = Nunchuck::Mouse.new(port, mouse)

nunchuck.init()
nunchuck.poll()
