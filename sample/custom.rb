require "nunchuck/device"

addr = "/dev/i2c-1"

nunchuck = Nunchuck::Device.new addr

loop do
  3.times do
    nunchuck.read_packet
  end
  
  p [
    nunchuck.jx,
    nunchuck.jy,
    nunchuck.ax,
    nunchuck.ay,
    nunchuck.az,
    nunchuck.c_button_pressed?,
    nunchuck.z_button_pressed?,
    nunchuck.digital_down?,  
    nunchuck.digital_up?,
    nunchuck.digital_left?,
    nunchuck.digital_right?              
  ]
  
  sleep 0.2
end
