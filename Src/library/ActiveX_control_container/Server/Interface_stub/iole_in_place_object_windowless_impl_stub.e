indexing
	description: "Implemented `IOleInPlaceObjectWindowless' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_STUB

inherit
	IOLE_IN_PLACE_OBJECT_WINDOWLESS_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		do
			-- Put Implementation here.
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			-- Put Implementation here.
		end

	in_place_deactivate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	uideactivate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	set_object_rects (lprc_pos_rect: TAG_RECT_RECORD; lprc_clip_rect: TAG_RECT_RECORD) is
			-- No description available.
			-- `lprc_pos_rect' [in].  
			-- `lprc_clip_rect' [in].  
		do
			-- Put Implementation here.
		end

	reactivate_and_undo is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_window_message (msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF) is
			-- No description available.
			-- `msg' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `pl_result' [out].  
		do
			-- Put Implementation here.
		end

	get_drop_target (pp_drop_target: CELL [IDROP_TARGET_INTERFACE]) is
			-- No description available.
			-- `pp_drop_target' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IOleInPlaceObjectWindowless_impl_stub %"ecom_control_library_IOleInPlaceObjectWindowless_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_STUB

