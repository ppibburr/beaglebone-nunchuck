require "nunchuck/nunchuck"

module Nunchuck          
  class Device
    NUNCHUCK_I2C_ADDRESS = 0x52
  
    AXIS_TRIM  = 6      # Deadban of the joystick's axi
    JX_NEUTRAL = 120.0  # Neutral position of the joystick's X axis
    JX_MIN     = 26     # The minimum value of the joysticks X axis
    JX_MAX     = 215    # The minimum value of the joysticks X axis
    JY_MIN     = 26     # The minimum value of the joysticks Y axis
    JY_MAX     = 215    # The maximum value of the joysticks Y axis
    JY_NEUTRAL = 132.0  # Neutral position of the joystick's Y axis
    
    # @param port [String] the path to read the device from
    # @param addr [Integer]
    def initialize port
      @ptr = ::Nunchuck::nunchuck_new(NUNCHUCK_I2C_ADDRESS, port)
    end
    
    # Wake up the nunchuck
    def init
      ::Nunchuck::nunchuck_init(self.to_ptr)    
    end
    
    # Updates the data
    def read_packet
      ::Nunchuck::nunchuck_read_packet(@ptr)    
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
  
    # Is the joystick pressed left?
    #
    # @return [Boolean] true if it is, false otherwise
    def digital_left?
      jx < (JX_NEUTRAL - AXIS_TRIM - 46)    
    end    
    
    # Is the joystick pressed right?
    #
    # @return [Boolean] true if it is, false otherwise
    def digital_right?
      jx > (JX_NEUTRAL + AXIS_TRIM + 46)
    end
    
    # Is the joystick pressed up?
    #
    # @return [Boolean] true if it is, false otherwise
    def digital_up?
      jy > (JY_NEUTRAL + AXIS_TRIM + 69)    
    end
    
    # Is the joystick pressed down?
    #
    # @return [Boolean] true if it is, false otherwise    
    def digital_down?
      jy < (JY_NEUTRAL - AXIS_TRIM - 69)    
    end    
    
    # Is the C button pressed?
    #
    # @return [Boolean] true if it is, false otherwise    
    def c_button_pressed?
      ::Nunchuck::nunchuck_get_bc @ptr    
    end
    
    # Is the Z button pressed right?
    #
    # @return [Boolean] true if it is, false otherwise    
    def z_button_pressed?
      ::Nunchuck::nunchuck_get_bz @ptr    
    end
  end
end
