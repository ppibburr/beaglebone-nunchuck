require "nunchuck/xinput/keypad"
require "xinput/remote"

port = ARGV[0]

unless port
  raise "Must pass 'port' value: ie, /dev/i2c-1"
end

keypad    = XInput::RemoteKeyboard.new ARGV[0]
nunchuck  = Nunchuck::KeyPad.new(port, keypad)

nunchuck.init()
nunchuck.poll()
