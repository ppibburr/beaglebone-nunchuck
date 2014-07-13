require "nunchuck/xinput/mouse"
require "xinput/local"

addr = "/dev/i2c-1"

mouse     = XInput::LocalMouse.new "127.0.0.1"
nunchuck  = Nunchuck::Mouse.new(addr, mouse)

nunchuck.init()
nunchuck.poll()
