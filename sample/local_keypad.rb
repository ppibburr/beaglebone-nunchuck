require "nunchuck/xinput/keypad"
require "xinput/local"

port = ARGV[0]

unless port
  raise "Must pass 'port' value: ie, /dev/i2c-1"
end

keypad    = XInput::LocalKeyboard.new
nunchuck  = Nunchuck::KeyPad.new(port, keypad)

nunchuck.init()
nunchuck.poll()
