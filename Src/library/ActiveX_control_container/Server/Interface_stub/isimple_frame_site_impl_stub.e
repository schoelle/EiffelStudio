indexing
	description: "Implemented `ISimpleFrameSite' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ISIMPLE_FRAME_SITE_IMPL_STUB

inherit
	ISIMPLE_FRAME_SITE_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	pre_message_filter (h_wnd: POINTER; msg: INTEGER; wp: INTEGER; lp: INTEGER; pl_result: INTEGER_REF; pdw_cookie: INTEGER_REF) is
			-- No description available.
			-- `h_wnd' [in].  
			-- `msg' [in].  
			-- `wp' [in].  
			-- `lp' [in].  
			-- `pl_result' [out].  
			-- `pdw_cookie' [out].  
		do
			-- Put Implementation here.
		end

	post_message_filter (h_wnd: POINTER; msg: INTEGER; wp: INTEGER; lp: INTEGER; pl_result: INTEGER_REF; dw_cookie: INTEGER) is
			-- No description available.
			-- `h_wnd' [in].  
			-- `msg' [in].  
			-- `wp' [in].  
			-- `lp' [in].  
			-- `pl_result' [out].  
			-- `dw_cookie' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: ISIMPLE_FRAME_SITE_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::ISimpleFrameSite_impl_stub %"ecom_control_library_ISimpleFrameSite_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- ISIMPLE_FRAME_SITE_IMPL_STUB

