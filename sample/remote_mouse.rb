require "nunchuck/xinput/mouse"
require "xinput/remote"

port = ARGV[0]

unless port
  raise "Must pass 'port' value: ie, /dev/i2c-1"
end

mouse    = XInput::RemoteMouse.new ARGV[0]
nunchuck = Nunchuck::Mouse.new(port, mouse)

nunchuck.init()
nunchuck.poll()

