require "xcb"
require "xinput/local"
require "socket"

module XInput
  class Service
    include Local
    def initialize port = 3333, host = "127.0.0.1", *o
      super *o
      
      @server = TCPServer.new host,port
    end
    
    def run
      q=@server.accept
      while s=q.gets
        p s
        a = s.split(" ").map do |q| q.to_i end
        next unless a.length == 7
        send_input! *a
      end  
    end
  end
end
