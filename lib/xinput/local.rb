require "xinput/device"
require "xinput/mouse"
require "xinput/keyboard"

module XInput
  # Implements an input device for the X Display of the local machine
  module Local
    attr_accessor :connection
    # @param connection [XCB::CONNECTION_T] the X11 connection to send events to
    def initialize connection = nil, *o
      super *o
      
      if !connection
        connection = XCB::connect(FFI::Pointer::NULL, FFI::Pointer::NULL)
        raise "X ConnectionError" if XCB::connection_has_error?(connection)
      end
      
      @connection = connection
    end
  
    def send_input type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
      XCBTest::xcb_test_fake_input connection, type, detail, time, window, root_x, root_y, device_id
    end
    
    def send_input! type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
      send_input type, detail, time, window, root_x, root_y, device_id
      XCB::flush connection
    end
  end
  
  # A Local Mouse Input Device
  class LocalMouse < Mouse
    include Local
  end 
  
  # A Local Keyboard Input Device
  class LocalKeypad < Keyboard
    include Local
  end   
end
