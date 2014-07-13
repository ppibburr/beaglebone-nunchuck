require "nunchuck/device"
require "nunchuck/xinput/device"

module Nunchuck
  class KeyPad < Device
    include X11InputDevice
    
    DEFAULT_MAP = {
      :z     => 41,
      :c     => 42, 
      :left  => 43, 
      :right => 44,
      :up    => 45,
      :down  => 46
    }
    
    # A loop that polls the nunchuck then sends the corresponding input events to X
    def poll
      bc = bz = dl = dr = du = dd = false
      
      while true;
        read_packet;
        read_packet
        
        next unless read_packet
        
        if c_button_pressed? and !bc
          bc = true
          
          xinput.keydown! @map[:c]
        elsif !c_button_pressed? and bc
          bc = false
          
          xinput.keyup! @map[:c]
        end
        
        if z_button_pressed? and !bz
          bz = true
          
          xinput.keydown! @map[:z]          
        elsif !z_button_pressed? and bz
          bz = false

          xinput.keyup! @map[:z]
        end
       
        if digital_right? and !dr
          dr = true
          
          xinput.keydown! @map[:right]          
        elsif !digital_right? and dr
          dr = false
          
          xinput.keyup! @map[:right]          
        end
        
        if digital_left? and !dl
          dl = true
        
          xinput.keydown! @map[:left]        
        elsif !digital_left? and dl
          dl = false
          
          xinput.keyup! @map[:left]          
        end 

        if digital_up? and !du
          du = true
        
          xinput.keydown! @map[:up]        
        elsif !digital_up? and du
          du = false
          
          xinput.keyup! @map[:up]          
        end
        
        if digital_down? and !dd
          dd = true
          
          xinput.keydown! @map[:down]          
        elsif !digital_down? and dd
          dd = false

          xinput.keyup! @map[:down]
        end 

        sleep POLL_RATE            
      end
	end
  end
end
