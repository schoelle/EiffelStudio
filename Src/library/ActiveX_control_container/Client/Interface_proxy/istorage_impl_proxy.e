indexing
	description: "Implemented `IStorage' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ISTORAGE_IMPL_PROXY

inherit
	ISTORAGE_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_istorage_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	create_stream (pwcs_name: STRING; grf_mode: INTEGER; reserved1: INTEGER; reserved2: INTEGER; ppstm: CELL [ISTREAM_INTERFACE]) is
			-- No description available.
			-- `pwcs_name' [in].  
			-- `grf_mode' [in].  
			-- `reserved1' [in].  
			-- `reserved2' [in].  
			-- `ppstm' [out].  
		do
			ccom_create_stream (initializer, pwcs_name, grf_mode, reserved1, reserved2, ppstm)
		end

	remote_open_stream (pwcs_name: STRING; cb_reserved1: INTEGER; reserved1: CHARACTER_REF; grf_mode: INTEGER; reserved2: INTEGER; ppstm: CELL [ISTREAM_INTERFACE]) is
			-- No description available.
			-- `pwcs_name' [in].  
			-- `cb_reserved1' [in].  
			-- `reserved1' [in].  
			-- `grf_mode' [in].  
			-- `reserved2' [in].  
			-- `ppstm' [out].  
		do
			ccom_remote_open_stream (initializer, pwcs_name, cb_reserved1, reserved1, grf_mode, reserved2, ppstm)
		end

	create_storage (pwcs_name: STRING; grf_mode: INTEGER; reserved1: INTEGER; reserved2: INTEGER; ppstg: CELL [ISTORAGE_INTERFACE]) is
			-- No description available.
			-- `pwcs_name' [in].  
			-- `grf_mode' [in].  
			-- `reserved1' [in].  
			-- `reserved2' [in].  
			-- `ppstg' [out].  
		do
			ccom_create_storage (initializer, pwcs_name, grf_mode, reserved1, reserved2, ppstg)
		end

	open_storage (pwcs_name: STRING; pstg_priority: ISTORAGE_INTERFACE; grf_mode: INTEGER; snb_exclude: WIRE_SNB_ALIAS; reserved: INTEGER; ppstg: CELL [ISTORAGE_INTERFACE]) is
			-- No description available.
			-- `pwcs_name' [in].  
			-- `pstg_priority' [in].  
			-- `grf_mode' [in].  
			-- `snb_exclude' [in].  
			-- `reserved' [in].  
			-- `ppstg' [out].  
		local
			pstg_priority_item: POINTER
			a_stub: ECOM_STUB
		do
			if pstg_priority /= Void then
				if (pstg_priority.item = default_pointer) then
					a_stub ?= pstg_priority
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pstg_priority_item := pstg_priority.item
			end
			ccom_open_storage (initializer, pwcs_name, pstg_priority_item, grf_mode, snb_exclude.item, reserved, ppstg)
		end

	copy_to (ciid_exclude: INTEGER; rgiid_exclude: ECOM_GUID; snb_exclude: WIRE_SNB_ALIAS; pstg_dest: ISTORAGE_INTERFACE) is
			-- No description available.
			-- `ciid_exclude' [in].  
			-- `rgiid_exclude' [in].  
			-- `snb_exclude' [in].  
			-- `pstg_dest' [in].  
		local
			pstg_dest_item: POINTER
			a_stub: ECOM_STUB
		do
			if pstg_dest /= Void then
				if (pstg_dest.item = default_pointer) then
					a_stub ?= pstg_dest
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pstg_dest_item := pstg_dest.item
			end
			ccom_copy_to (initializer, ciid_exclude, rgiid_exclude.item, snb_exclude.item, pstg_dest_item)
		end

	move_element_to (pwcs_name: STRING; pstg_dest: ISTORAGE_INTERFACE; pwcs_new_name: STRING; grf_flags: INTEGER) is
			-- No description available.
			-- `pwcs_name' [in].  
			-- `pstg_dest' [in].  
			-- `pwcs_new_name' [in].  
			-- `grf_flags' [in].  
		local
			pstg_dest_item: POINTER
			a_stub: ECOM_STUB
		do
			if pstg_dest /= Void then
				if (pstg_dest.item = default_pointer) then
					a_stub ?= pstg_dest
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pstg_dest_item := pstg_dest.item
			end
			ccom_move_element_to (initializer, pwcs_name, pstg_dest_item, pwcs_new_name, grf_flags)
		end

	commit (grf_commit_flags: INTEGER) is
			-- No description available.
			-- `grf_commit_flags' [in].  
		do
			ccom_commit (initializer, grf_commit_flags)
		end

	revert is
			-- No description available.
		do
			ccom_revert (initializer)
		end

	remote_enum_elements (reserved1: INTEGER; cb_reserved2: INTEGER; reserved2: CHARACTER_REF; reserved3: INTEGER; ppenum: CELL [IENUM_STATSTG_INTERFACE]) is
			-- No description available.
			-- `reserved1' [in].  
			-- `cb_reserved2' [in].  
			-- `reserved2' [in].  
			-- `reserved3' [in].  
			-- `ppenum' [out].  
		do
			ccom_remote_enum_elements (initializer, reserved1, cb_reserved2, reserved2, reserved3, ppenum)
		end

	destroy_element (pwcs_name: STRING) is
			-- No description available.
			-- `pwcs_name' [in].  
		do
			ccom_destroy_element (initializer, pwcs_name)
		end

	rename_element (pwcs_old_name: STRING; pwcs_new_name: STRING) is
			-- No description available.
			-- `pwcs_old_name' [in].  
			-- `pwcs_new_name' [in].  
		do
			ccom_rename_element (initializer, pwcs_old_name, pwcs_new_name)
		end

	set_element_times (pwcs_name: STRING; pctime: X_FILETIME_RECORD; patime: X_FILETIME_RECORD; pmtime: X_FILETIME_RECORD) is
			-- No description available.
			-- `pwcs_name' [in].  
			-- `pctime' [in].  
			-- `patime' [in].  
			-- `pmtime' [in].  
		do
			ccom_set_element_times (initializer, pwcs_name, pctime.item, patime.item, pmtime.item)
		end

	set_class (clsid: ECOM_GUID) is
			-- No description available.
			-- `clsid' [in].  
		do
			ccom_set_class (initializer, clsid.item)
		end

	set_state_bits (grf_state_bits: INTEGER; grf_mask: INTEGER) is
			-- No description available.
			-- `grf_state_bits' [in].  
			-- `grf_mask' [in].  
		do
			ccom_set_state_bits (initializer, grf_state_bits, grf_mask)
		end

	stat (pstatstg: TAG_STATSTG_RECORD; grf_stat_flag: INTEGER) is
			-- No description available.
			-- `pstatstg' [out].  
			-- `grf_stat_flag' [in].  
		do
			ccom_stat (initializer, pstatstg.item, grf_stat_flag)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_istorage_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_create_stream (cpp_obj: POINTER; pwcs_name: STRING; grf_mode: INTEGER; reserved1: INTEGER; reserved2: INTEGER; ppstm: CELL [ISTREAM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_remote_open_stream (cpp_obj: POINTER; pwcs_name: STRING; cb_reserved1: INTEGER; reserved1: CHARACTER_REF; grf_mode: INTEGER; reserved2: INTEGER; ppstm: CELL [ISTREAM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER,EIF_OBJECT,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_create_storage (cpp_obj: POINTER; pwcs_name: STRING; grf_mode: INTEGER; reserved1: INTEGER; reserved2: INTEGER; ppstg: CELL [ISTORAGE_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_open_storage (cpp_obj: POINTER; pwcs_name: STRING; pstg_priority: POINTER; grf_mode: INTEGER; snb_exclude: POINTER; reserved: INTEGER; ppstg: CELL [ISTORAGE_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,ecom_control_library::IStorage *,EIF_INTEGER,ecom_control_library::wireSNB,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_copy_to (cpp_obj: POINTER; ciid_exclude: INTEGER; rgiid_exclude: POINTER; snb_exclude: POINTER; pstg_dest: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_INTEGER,GUID *,ecom_control_library::wireSNB,ecom_control_library::IStorage *)"
		end

	ccom_move_element_to (cpp_obj: POINTER; pwcs_name: STRING; pstg_dest: POINTER; pwcs_new_name: STRING; grf_flags: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,ecom_control_library::IStorage *,EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_commit (cpp_obj: POINTER; grf_commit_flags: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_revert (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"]()"
		end

	ccom_remote_enum_elements (cpp_obj: POINTER; reserved1: INTEGER; cb_reserved2: INTEGER; reserved2: CHARACTER_REF; reserved3: INTEGER; ppenum: CELL [IENUM_STATSTG_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_OBJECT,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_destroy_element (cpp_obj: POINTER; pwcs_name: STRING) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_rename_element (cpp_obj: POINTER; pwcs_old_name: STRING; pwcs_new_name: STRING) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_set_element_times (cpp_obj: POINTER; pwcs_name: STRING; pctime: POINTER; patime: POINTER; pmtime: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_OBJECT,ecom_control_library::_FILETIME *,ecom_control_library::_FILETIME *,ecom_control_library::_FILETIME *)"
		end

	ccom_set_class (cpp_obj: POINTER; clsid: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](GUID *)"
		end

	ccom_set_state_bits (cpp_obj: POINTER; grf_state_bits: INTEGER; grf_mask: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER)"
		end

	ccom_stat (cpp_obj: POINTER; pstatstg: POINTER; grf_stat_flag: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](ecom_control_library::tagSTATSTG *,EIF_INTEGER)"
		end

	ccom_delete_istorage_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"]()"
		end

	ccom_create_istorage_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IStorage_impl_proxy %"ecom_control_library_IStorage_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- ISTORAGE_IMPL_PROXY

