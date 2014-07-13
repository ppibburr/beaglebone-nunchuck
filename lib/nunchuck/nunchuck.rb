require "ffi"

module Nunchuck
  extend FFI::Library
  
  ffi_lib File.join(File.dirname(__FILE__), "ext", "lib", "nunchuck.so")
  
  attach_function :nunchuck_new, [:int, :string], :pointer
  attach_function :nunchuck_init, [:pointer], :bool
  attach_function :nunchuck_read_packet, [:pointer], :bool
  attach_function :nunchuck_get_jx, [:pointer], :float
  attach_function :nunchuck_get_jy, [:pointer], :float
  attach_function :nunchuck_get_ax, [:pointer], :float
  attach_function :nunchuck_get_ay, [:pointer], :float
  attach_function :nunchuck_get_az, [:pointer], :float
  attach_function :nunchuck_get_bc, [:pointer], :bool 
  attach_function :nunchuck_get_bz, [:pointer], :bool  
  attach_function :nunchuck_get_port, [:pointer], :string
end
