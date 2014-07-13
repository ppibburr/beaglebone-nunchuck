module XInput
  class Device
    def send_input type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
    end
    
    def send_input! type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
      send_input type, detail, time, window, root_x, root_y, device_id
    end
  end
end
