require "xinput/device"
require "xinput/mouse"
require "xinput/keyboard"
require "socket"

module XInput
  # Implements an input device for the X Display of a remote machine
  module Remote
    attr_accessor :target
    
    # @param host [String] the host
    # @param port [Integer] the port
    def initialize host, port = 3333, *o
      super *o
      @target = TCPSocket.new(host,port)
    end
    
    def send_input type, detail, time = 0, window = 0, root_x = 0, root_y = 0, device_id = 0
      @target.puts [type, detail, time, window, root_x, root_y, device_id].join(" ")
    end
  end
  
  class RemoteMouse < Mouse
    include Remote
  end
  
  class RemoteKeyboard < Keyboard
    include Remote
  end  
end
