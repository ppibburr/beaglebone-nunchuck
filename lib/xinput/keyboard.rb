module XInput
  class Keyboard < Device
    def key_down! key
      send_input! 2, key
    end
    
    def key_up! key
      send_input! 3, key
    end    
    
    def key_press! key
      key_down! key
      key_up!   key
    end
  end
end
