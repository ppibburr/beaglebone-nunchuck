module XCBTest
  extend FFI::Library
	  
  ffi_lib "libxcb-xtest"
  attach_function :xcb_test_fake_input, [:pointer,:uint8,:uint8,:uint32,:uint32,:int16,:int16,:uint8], XCB::XCB_VOID_COOKIE_T.by_value
end
