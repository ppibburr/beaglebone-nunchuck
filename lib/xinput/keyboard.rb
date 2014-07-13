module XInput
  class Keyboard < Device
    # emits a keydown event
    #
    # @param key [Integer]
    #
    # @return [void]
    def key_down! key
      send_input! 2, key
    end

    # emits a keyup event
    #
    # @param key [Integer]
    #
    # @return [void]
    def key_up! key
      send_input! 3, key
    end    
    
    # emits a keydown event, followed by a keyup event
    #
    # @param key [Integer]
    #
    # @return [void]    
    def key_press! key
      key_down! key
      key_up!   key
    end
  end
end
