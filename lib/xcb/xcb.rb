module XCB
    extend FFI::Library
    
    ffi_lib "libxcb"
  
	class XCB_VOID_COOKIE_T < FFI::Struct
	  layout :sequence,:uint	end  
  
	class KEY_PRESS_EVENT_T < FFI::Struct
	  layout :response_type,:uint8,:detail,:uint8,:sequence,:uint16,:time,:uint32,:root,:uint32,:event,:uint32,:child,:uint32,:root_x,:int16,:root_y,:int16,:event_x,:int16,:event_y,:int16,:state,:uint16,:same_screen,:uint8,:pad0,:uint8
	end

	class BUTTON_PRESS_EVENT_T < FFI::Struct
	  layout :response_type,:uint8,:detail,:uint8,:sequence,:uint16,:time,:uint32,:root,:uint32,:event,:uint32,:child,:uint32,:root_x,:int16,:root_y,:int16,:event_x,:int16,:event_y,:int16,:state,:uint16,:same_screen,:uint8,:pad0,:uint8
	end

	class ENTER_NOTIFY_EVENT_T < FFI::Struct
	  layout :response_type,:uint8,:detail,:uint8,:sequence,:uint16,:time,:uint32,:root,:uint32,:event,:uint32,:child,:uint32,:root_x,:int16,:root_y,:int16,:event_x,:int16,:event_y,:int16,:state,:uint16,:mode,:uint8,:same_screen_focus,:uint8
	end
	
	class SETUP_T < FFI::Struct
	  layout :status,:uint8,:pad0,:uint8,:protocol_major_version,:uint16,:protocol_minor_version,:uint16,:length,:uint16,:release_number,:uint32,:resource_id_base,:uint32,:resource_id_mask,:uint32,:motion_buffer_size,:uint32,:vendor_len,:uint16,:maximum_request_length,:uint16,:roots_len,:uint8,:pixmap_formats_len,:uint8,:image_byte_order,:uint8,:bitmap_format_bit_order,:uint8,:bitmap_format_scanline_unit,:uint8,:bitmap_format_scanline_pad,:uint8,:min_keycode,:uint8,:max_keycode,:uint8,:pad1,[:uint8, 4]
	end

	class SCREEN_T < FFI::Struct
	  layout :root,:uint32,:default_colormap,:uint32,:white_pixel,:uint32,:black_pixel,:uint32,:current_input_masks,:uint32,:width_in_pixels,:uint16,:height_in_pixels,:uint16,:width_in_millimeters,:uint16,:height_in_millimeters,:uint16,:min_installed_maps,:uint16,:max_installed_maps,:uint16,:root_visual,:uint32,:backing_stores,:uint8,:save_unders,:uint8,:root_depth,:uint8,:allowed_depths_len,:uint8
	end

	class SCREEN_ITERATOR_T < FFI::Struct
	  layout :data,XCB::SCREEN_T.by_ref,:rem,:int,:index,:int
	end

	attach_function :xcb_connect,[:pointer, :pointer],:pointer
	attach_function :xcb_connection_has_error,[:pointer],:bool	
	attach_function :xcb_get_setup,[:pointer],XCB::SETUP_T.by_ref
	attach_function :xcb_setup_roots_iterator,[:pointer],XCB::SCREEN_ITERATOR_T.by_value
    attach_function :xcb_flush,[:pointer],:int
	attach_function :xcb_screen_next,[:pointer],:void
	
	def self.connection_has_error?(c)
      self.xcb_connection_has_error(c)	
	end
	
	def self.screen_next *o, &b
	  ::XCB.send(:xcb_screen_next,*o,&b)
	end
   

	def self.get_setup *o, &b
	  ::XCB.send(:xcb_get_setup,*o,&b)
	end	

	def self.connect *o, &b
	  ::XCB.send(:xcb_connect,*o,&b)
	end

	def self.setup_roots_iterator *o, &b
	  ::XCB.send(:xcb_setup_roots_iterator,*o,&b)
	end

	def self.flush *o, &b
	  ::XCB.send(:xcb_flush,*o,&b)
	end
end
