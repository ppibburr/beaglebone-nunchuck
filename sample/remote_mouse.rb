require "nunchuck/xinput/mouse"
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

mouse    = XInput::RemoteMouse.new host
nunchuck = Nunchuck::Mouse.new(port, mouse)

nunchuck.init()
nunchuck.poll()

