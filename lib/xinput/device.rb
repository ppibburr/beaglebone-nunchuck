module XInput
  # Emulates an input device for use with X11
  class Device
    # sends an input event
    #
    # @param type [Integer]
    # @param detail [Integer]
    # @param time [Integer]
    # @param window [Integer]
    # @param root_x [Integer]
    # @param root_y [Integer]
    # @param device_id [Integer]
    #
    # @return [void]    
    def send_input type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
    end
    
    # Calls #send_input then performs ::XCB.flush(c) on the connection
    #
    # @see #send_input
    def send_input! type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
      send_input type, detail, time, window, root_x, root_y, device_id
    end
  end
end
