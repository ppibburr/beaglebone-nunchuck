require "nunchuck/nunchuck"

module Nunchuck          
  class Device
    AXIS_TRIM  = 6
    JX_NEUTRAL = 120.0
    JX_MIN     = 26
    JX_MAX     = 215
    JY_MIN     = 26
    JY_MAX     = 215    
    JY_NEUTRAL = 132.0
    
    def initialize port, addr=0x52
      @ptr = ::Nunchuck::nunchuck_new(addr, port)
    end
    
    def init
      ::Nunchuck::nunchuck_init(self.to_ptr)    
    end
    
    def read_packet
      ::Nunchuck::nunchuck_read_packet(@ptr)    
    end    
    
    def digital_left?
      jx < (JX_NEUTRAL - AXIS_TRIM - 46)    
    end
    
    def axis_ax
      ::Nunchuck::nunchuck_get_ax @ptr
    end
    
    def axis_ay
      ::Nunchuck::nunchuck_get_ay @ptr    
    end
    
    def axis_az
      ::Nunchuck::nunchuck_get_az @ptr    
    end
    
    def axis_jx
      ::Nunchuck::nunchuck_get_jx @ptr    
    end
    
    def axis_jy
      ::Nunchuck::nunchuck_get_jy @ptr    
    end
    
   def digital_right?
      jx > (JX_NEUTRAL + AXIS_TRIM + 46)
    end
    
    def digital_up?
      jy > (JY_NEUTRAL + AXIS_TRIM + 69)    
    end
    
    def digital_down?
      jy < (JY_NEUTRAL - AXIS_TRIM - 69)    
    end    
    
    def c_button_pressed?
      ::Nunchuck::nunchuck_get_bc @ptr    
    end
    
    def z_button_pressed?
      ::Nunchuck::nunchuck_get_bz @ptr    
    end
  end
end
