require "nunchuck/device"

port = ARGV[0]

unless port
  raise "Must pass 'port' value: ie, /dev/i2c-1"
end

nunchuck = Nunchuck::Device.new port
nunchuck.init

loop do
  3.times do
    nunchuck.read_packet
  end
  
  p [
    nunchuck.axis_jx,
    nunchuck.axis_jy,
    nunchuck.axis_ax,
    nunchuck.axis_ay,
    nunchuck.axis_az,
    nunchuck.c_button_pressed?,
    nunchuck.z_button_pressed?,
    nunchuck.digital_down?,  
    nunchuck.digital_up?,
    nunchuck.digital_left?,
    nunchuck.digital_right?              
  ]
  
  sleep 0.2
end
