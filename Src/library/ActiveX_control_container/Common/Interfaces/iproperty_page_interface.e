indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPROPERTY_PAGE_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	set_page_site_user_precondition (p_page_site: IPROPERTY_PAGE_SITE_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `set_page_site'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	activate_user_precondition (hwnd_parent: POINTER; p_rect: TAG_RECT_RECORD; b_modal: INTEGER): BOOLEAN is
			-- User-defined preconditions for `activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	deactivate_user_precondition: BOOLEAN is
			-- User-defined preconditions for `deactivate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_page_info_user_precondition (p_page_info: TAG_PROPPAGEINFO_RECORD): BOOLEAN is
			-- User-defined preconditions for `get_page_info'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_objects_user_precondition (c_objects: INTEGER; ppunk: CELL [ECOM_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `set_objects'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	show_user_precondition (n_cmd_show: INTEGER): BOOLEAN is
			-- User-defined preconditions for `show'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	move_user_precondition (p_rect: TAG_RECT_RECORD): BOOLEAN is
			-- User-defined preconditions for `move'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_page_dirty_user_precondition: BOOLEAN is
			-- User-defined preconditions for `is_page_dirty'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	apply_user_precondition: BOOLEAN is
			-- User-defined preconditions for `apply'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	help_user_precondition (psz_help_dir: STRING): BOOLEAN is
			-- User-defined preconditions for `help'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	translate_accelerator_user_precondition (p_msg: TAG_MSG_RECORD): BOOLEAN is
			-- User-defined preconditions for `translate_accelerator'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	set_page_site (p_page_site: IPROPERTY_PAGE_SITE_INTERFACE) is
			-- No description available.
			-- `p_page_site' [in].  
		require
			set_page_site_user_precondition: set_page_site_user_precondition (p_page_site)
		deferred

		end

	activate (hwnd_parent: POINTER; p_rect: TAG_RECT_RECORD; b_modal: INTEGER) is
			-- No description available.
			-- `hwnd_parent' [in].  
			-- `p_rect' [in].  
			-- `b_modal' [in].  
		require
			non_void_p_rect: p_rect /= Void
			valid_p_rect: p_rect.item /= default_pointer
			activate_user_precondition: activate_user_precondition (hwnd_parent, p_rect, b_modal)
		deferred

		end

	deactivate is
			-- No description available.
		require
			deactivate_user_precondition: deactivate_user_precondition
		deferred

		end

	get_page_info (p_page_info: TAG_PROPPAGEINFO_RECORD) is
			-- No description available.
			-- `p_page_info' [out].  
		require
			non_void_p_page_info: p_page_info /= Void
			valid_p_page_info: p_page_info.item /= default_pointer
			get_page_info_user_precondition: get_page_info_user_precondition (p_page_info)
		deferred

		end

	set_objects (c_objects: INTEGER; ppunk: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `c_objects' [in].  
			-- `ppunk' [in].  
		require
			non_void_ppunk: ppunk /= Void
			valid_ppunk: ppunk.item /= Void
			set_objects_user_precondition: set_objects_user_precondition (c_objects, ppunk)
		deferred

		end

	show (n_cmd_show: INTEGER) is
			-- No description available.
			-- `n_cmd_show' [in].  
		require
			show_user_precondition: show_user_precondition (n_cmd_show)
		deferred

		end

	move (p_rect: TAG_RECT_RECORD) is
			-- No description available.
			-- `p_rect' [in].  
		require
			non_void_p_rect: p_rect /= Void
			valid_p_rect: p_rect.item /= default_pointer
			move_user_precondition: move_user_precondition (p_rect)
		deferred

		end

	is_page_dirty is
			-- No description available.
		require
			is_page_dirty_user_precondition: is_page_dirty_user_precondition
		deferred

		end

	apply is
			-- No description available.
		require
			apply_user_precondition: apply_user_precondition
		deferred

		end

	help (psz_help_dir: STRING) is
			-- No description available.
			-- `psz_help_dir' [in].  
		require
			help_user_precondition: help_user_precondition (psz_help_dir)
		deferred

		end

	translate_accelerator (p_msg: TAG_MSG_RECORD) is
			-- No description available.
			-- `p_msg' [in].  
		require
			non_void_p_msg: p_msg /= Void
			valid_p_msg: p_msg.item /= default_pointer
			translate_accelerator_user_precondition: translate_accelerator_user_precondition (p_msg)
		deferred

		end

end -- IPROPERTY_PAGE_INTERFACE

