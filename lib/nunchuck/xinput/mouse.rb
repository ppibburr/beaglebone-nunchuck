require "nunchuck/device"
require "nunchuck/xinput/device"

module Nunchuck  
  class Mouse < Device
    include X11InputDevice
    
    DEFAULT_MAP = {
      :c => MOUSE_LEFT_BUTTON,
      :z => MOUSE_RIGHT_BUTTON
    }
    
    # A loop that polls the nunchuck then sends corresponding inputs to X11
    def poll
      bc = bz = false

      while true;
        read_packet;
        read_packet
        
        next unless read_packet
        
        if c_button_pressed? and !bc
          xinput.button_down! @map[:c]
          
          bc = true
        elsif !device.bc and bc 
          xinput.button_up! @map[:c]
          bc = false
        end
        
        if device.bz and !bz
          xinput.button_down! @map[:z]
          bz = true
        elsif !device.bz and bz 
          xinput.button_up! @map[:z]
          bz = false
        end    
      
        xtrim1 = (::Nunchuck::Device::JX_NEUTRAL - ::Nunchuck::Device::AXIS_TRIM)
        xtrim2 = (::Nunchuck::Device::JX_NEUTRAL + ::Nunchuck::Device::AXIS_TRIM)

        ytrim1 = (::Nunchuck::Device::JY_NEUTRAL - ::Nunchuck::Device::AXIS_TRIM)
        ytrim2 = (::Nunchuck::Device::JY_NEUTRAL + ::Nunchuck::Device::AXIS_TRIM)
      
        
        xmax = ::Nunchuck::Device::JX_MAX - ::Nunchuck::Device::JX_MIN
        xmin = 0
        x = axis_jx() - ::Nunchuck::Device::JX_MIN
        x_polar = 1
        
        ymax = ::Nunchuck::Device::JY_MAX - ::Nunchuck::Device::JY_MIN
        ymin = 0
        y = axis_jy() - ::Nunchuck::Device::JY_MIN
        y_polar = 1      
        
        nx = ny = 0

        changed = true

        if (axis_jx() < xtrim1)
          pct = x.to_f/(xmax * 0.5)
        
          i = (pct*MOTION_FAST).floor   
          
          if i == 0 then i = 1 end
             
          nx = fast - i   
           
          x_polar = -1   
        elsif (axis_jx() > xtrim2)
          pct = (x.to_f-(xmax * 0.5)) / (xmax * 0.5)
        
          nx = (pct*MOTION_FAST).floor
        else
          changed = false         
        end
        
        if (axis_jy() < ytrim1)
          pct = y.to_f/(ymax * 0.5)
        
          i = (pct*MOTION_FAST).floor   
          
          if i == 0 then i = 1 end
             
          ny = fast - i  
          
          changed = true    
        elsif (axis_jy() > ytrim2)
          pct = (y.to_f-(ymax * 0.5)) / (ymax * 0.5)
        
          ny = (pct*MOTION_FAST).floor    
          
          y_polar = -1
          
          changed = true
        else
          changed = false unless changed     
        end
        
        if changed
          xinput.motion! nx*x_polar,ny*y_polar
        end
        
        sleep POLL_RATE
      end
    end
  end
end
