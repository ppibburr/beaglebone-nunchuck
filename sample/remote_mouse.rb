require "nunchuck/xinput/mouse"
require "xinput/remote"

addr = "/dev/i2c-1"

mouse    = XInput::RemoteMouse.new "127.0.0.1"
nunchuck = Nunchuck::Mouse.new(addr, mouse)

