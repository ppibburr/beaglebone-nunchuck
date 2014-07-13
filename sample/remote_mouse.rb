require "nunchuck/xinput/mouse"
require "xinput/remote"

port = "/dev/i2c-1"

mouse    = XInput::RemoteMouse.new ARGV[0]
nunchuck = Nunchuck::Mouse.new(port, mouse)

nunchuck.init()
nunchuck.poll()

