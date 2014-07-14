require "nunchuck/xinput/keypad"
require "xinput/remote"

def usage()
  puts "ruby -I./lib ./sample/remote_mouse.rb XXX.XXX.X.X /dev/i2c-N"
end


host = ARGV[0]
port = ARGV[1]

unless host
  puts "Must pass 'host' value: ie, 127.0.0.1\n"
  usage()
  exit(127)
end

unless port
  puts "Must pass 'port' value: ie, /dev/i2c-1\n"
  usage()
  exit(127)
end

keypad    = XInput::RemoteKeyboard.new host
nunchuck  = Nunchuck::KeyPad.new(port, keypad)

nunchuck.init()
nunchuck.poll()
