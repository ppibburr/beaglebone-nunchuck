module XInput
  class Mouse < Device
    def motion! x,y
      send_input! 6,1,0,0,x,y,0
    end
    
    def button_down! button
      send_input! 4, button
    end
    
    def button_up! button
      send_input! 5, button
    end  
    
    def click! button
      button_down! button
      button_up!   button
    end  
  end
end
