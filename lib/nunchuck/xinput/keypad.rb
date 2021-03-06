require "nunchuck/device"
require "nunchuck/xinput/device"

module Nunchuck
  class KeyPad < Device
    include X11InputDevice
    
    DEFAULT_MAP = {
      :z     => 41, # f
      :c     => 42, # g
      :left  => 43, # h
      :right => 44, # j
      :up    => 45, # k
      :down  => 46  # l
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
          
          xinput.key_down! @map[:c]
        elsif !c_button_pressed? and bc
          bc = false
          
          xinput.key_up! @map[:c]
        end
        
        if z_button_pressed? and !bz
          bz = true
          
          xinput.key_down! @map[:z]          
        elsif !z_button_pressed? and bz
          bz = false

          xinput.key_up! @map[:z]
        end
       
        if digital_right? and !dr
          dr = true
          
          xinput.key_down! @map[:right]          
        elsif !digital_right? and dr
          dr = false
          
          xinput.key_up! @map[:right]          
        end
        
        if digital_left? and !dl
          dl = true
        
          xinput.key_down! @map[:left]        
        elsif !digital_left? and dl
          dl = false
          
          xinput.key_up! @map[:left]          
        end 

        if digital_up? and !du
          du = true
        
          xinput.key_down! @map[:up]        
        elsif !digital_up? and du
          du = false
          
          xinput.key_up! @map[:up]          
        end
        
        if digital_down? and !dd
          dd = true
          
          xinput.key_down! @map[:down]          
        elsif !digital_down? and dd
          dd = false

          xinput.key_up! @map[:down]
        end 

        sleep POLL_RATE            
      end
	end
  end
end
