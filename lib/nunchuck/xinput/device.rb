module Nunchuck  
  module X11InputDevice
    POLL_RATE = 0.016
  
    MOUSE_BUTTON_LEFT   = 1
    MOUSE_BUTTON_MIDDLE = 2
    MOUSE_BUTTON_RIGHT  = 3
  
    DEFAULT_MAP = {
    
    }
  
    attr_accessor :xinput, :map
    
    # @param port [String] the path to read the device from
    # @param xinput [XInput::Device] an XInput::Device to drive
    # @param map [Hash] map of device inputs to X11 keycodes
    def initialize port, xinput, map = nil
      raise "Map must be Hash" if map and !map.is_a?(Hash)
      
      super port
      
      unless map
        map = self.class::DEFAULT_MAP
      end
      
      self.class::DEFAULT_MAP.keys.each do |k|
        map[k] ||= self.class::DEFAULT_MAP[k]
      end
      
      @map    = map
      @xinput = xinput
    end
    
    # Virtual method
    def poll
      # ...
    end
  end
end
