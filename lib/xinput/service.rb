require "xcb"
require "xinput/local"
require "socket"

module XInput
  # Implements a X Input Service to send inputs from remote devices to the local X Display
  class Service
    include Local
    
    # @param port [Integer] the port
    # @param host [String] the host
    def initialize port = 3333, host = "127.0.0.1", *o
      super *o
      
      @server = TCPServer.new host,port
    end
    
    # Waits for a connection then queries the socket for valid data then sends the inputs 
    def run
      q=@server.accept
      while s=q.gets
        a = s.split(" ").map do |q| q.to_i end
        next unless a.length == 7
        send_input! *a
      end  
    end
  end
end
