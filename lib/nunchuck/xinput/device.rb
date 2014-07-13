module Nunchuck  
  module X11InputDevice
    POLL_RATE = 0.13
  
    DEFAULT_MAP = {
    
    }
  
    attr_accessor :xinput, :map
    def initialize host, xinput, map = nil, port = 0x52
      raise "Map must be Hash" if map and !map.is_a?(Hash)
      
      super host,port
      
      unless map
        map = self.class::DEFAULT_MAP
      end
      
      self.class::DEFAULT_MAP.keys.each do |k|
        map[k] ||= self.class::DEFAULT_MAP[k]
      end
      
      @map    = map
      @xinput = xinput
    end
    
    def poll
      # ...
    end
  end
end
