beaglebone-nunchuck
===================

Ruby library for using a Wii Nunchuck on a beaglebone.  

Extra Features
===  
* Provides a library for using the nunchuck as a X11 Input Device.  
* Provides a library for using the nunchuck as an X11 Input Device on remote machines.  

Build
===
Build the c extension:  
`ruby ./setup.rb`

Usage
===
`ruby -I./lib ...`  
or  
`export RUBYLIB=$RUBYLIB:./lib`


Example
===
```ruby
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
```

HOWTO
===
Use a beaglebone with nunchuck to send inputs to a remote machine:  
Port 3333 is default.  

```sh
# ** This is the remote machine **
# Replace 'XXX.XXX.X.X' with the remotes IP
RUBYLIB=$RUBYLIB:./lib bin/nunchuck-xinput-service XXX.XXX.X.X
```

```sh
# ** This is the beaglebone ***
# Replace 'XXX.XXX.X.X' with the remotes IP
ruby -I./lib ./sample/remote_mouse.rb XXX.XXX.X.X
```
