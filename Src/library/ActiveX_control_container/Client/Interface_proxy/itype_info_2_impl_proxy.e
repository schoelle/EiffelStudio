indexing
	description: "Implemented `ITypeInfo_2' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ITYPE_INFO_2_IMPL_PROXY

inherit
	ITYPE_INFO_2_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_itype_info_2_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	remote_get_type_attr (pp_type_attr: CELL [TAG_TYPEATTR_RECORD]; p_dummy: INTEGER_REF) is
			-- No description available.
			-- `pp_type_attr' [out].  
			-- `p_dummy' [out].  
		do
			ccom_remote_get_type_attr (initializer, pp_type_attr, p_dummy)
		end

	get_type_comp (pp_tcomp: CELL [ITYPE_COMP_INTERFACE]) is
			-- No description available.
			-- `pp_tcomp' [out].  
		do
			ccom_get_type_comp (initializer, pp_tcomp)
		end

	remote_get_func_desc (a_index: INTEGER; pp_func_desc: CELL [TAG_FUNCDESC_RECORD]; p_dummy: INTEGER_REF) is
			-- No description available.
			-- `a_index' [in].  
			-- `pp_func_desc' [out].  
			-- `p_dummy' [out].  
		do
			ccom_remote_get_func_desc (initializer, a_index, pp_func_desc, p_dummy)
		end

	remote_get_var_desc (a_index: INTEGER; pp_var_desc: CELL [TAG_VARDESC_RECORD]; p_dummy: INTEGER_REF) is
			-- No description available.
			-- `a_index' [in].  
			-- `pp_var_desc' [out].  
			-- `p_dummy' [out].  
		do
			ccom_remote_get_var_desc (initializer, a_index, pp_var_desc, p_dummy)
		end

	remote_get_names (memid: INTEGER; rg_bstr_names: CELL [STRING]; c_max_names: INTEGER; pc_names: INTEGER_REF) is
			-- No description available.
			-- `memid' [in].  
			-- `rg_bstr_names' [out].  
			-- `c_max_names' [in].  
			-- `pc_names' [out].  
		do
			ccom_remote_get_names (initializer, memid, rg_bstr_names, c_max_names, pc_names)
		end

	get_ref_type_of_impl_type (a_index: INTEGER; p_ref_type: INTEGER_REF) is
			-- No description available.
			-- `a_index' [in].  
			-- `p_ref_type' [out].  
		do
			ccom_get_ref_type_of_impl_type (initializer, a_index, p_ref_type)
		end

	get_impl_type_flags (a_index: INTEGER; p_impl_type_flags: INTEGER_REF) is
			-- No description available.
			-- `a_index' [in].  
			-- `p_impl_type_flags' [out].  
		do
			ccom_get_impl_type_flags (initializer, a_index, p_impl_type_flags)
		end

	local_get_ids_of_names is
			-- No description available.
		do
			ccom_local_get_ids_of_names (initializer)
		end

	local_invoke is
			-- No description available.
		do
			ccom_local_invoke (initializer)
		end

	remote_get_documentation (memid: INTEGER; ref_ptr_flags: INTEGER; p_bstr_name: CELL [STRING]; p_bstr_doc_string: CELL [STRING]; pdw_help_context: INTEGER_REF; p_bstr_help_file: CELL [STRING]) is
			-- No description available.
			-- `memid' [in].  
			-- `ref_ptr_flags' [in].  
			-- `p_bstr_name' [out].  
			-- `p_bstr_doc_string' [out].  
			-- `pdw_help_context' [out].  
			-- `p_bstr_help_file' [out].  
		do
			ccom_remote_get_documentation (initializer, memid, ref_ptr_flags, p_bstr_name, p_bstr_doc_string, pdw_help_context, p_bstr_help_file)
		end

	remote_get_dll_entry (memid: INTEGER; invkind: INTEGER; ref_ptr_flags: INTEGER; p_bstr_dll_name: CELL [STRING]; p_bstr_name: CELL [STRING]; pw_ordinal: INTEGER_REF) is
			-- No description available.
			-- `memid' [in].  
			-- `invkind' [in]. See ECOM_TAG_INVOKEKIND_ENUM for possible `invkind' values. 
			-- `ref_ptr_flags' [in].  
			-- `p_bstr_dll_name' [out].  
			-- `p_bstr_name' [out].  
			-- `pw_ordinal' [out].  
		do
			ccom_remote_get_dll_entry (initializer, memid, invkind, ref_ptr_flags, p_bstr_dll_name, p_bstr_name, pw_ordinal)
		end

	get_ref_type_info (hreftype: INTEGER; pp_tinfo: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
			-- `hreftype' [in].  
			-- `pp_tinfo' [out].  
		do
			ccom_get_ref_type_info (initializer, hreftype, pp_tinfo)
		end

	local_address_of_member is
			-- No description available.
		do
			ccom_local_address_of_member (initializer)
		end

	remote_create_instance (riid: ECOM_GUID; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `riid' [in].  
			-- `ppv_obj' [out].  
		do
			ccom_remote_create_instance (initializer, riid.item, ppv_obj)
		end

	get_mops (memid: INTEGER; p_bstr_mops: CELL [STRING]) is
			-- No description available.
			-- `memid' [in].  
			-- `p_bstr_mops' [out].  
		do
			ccom_get_mops (initializer, memid, p_bstr_mops)
		end

	remote_get_containing_type_lib (pp_tlib: CELL [ITYPE_LIB_2_INTERFACE]; p_index: INTEGER_REF) is
			-- No description available.
			-- `pp_tlib' [out].  
			-- `p_index' [out].  
		do
			ccom_remote_get_containing_type_lib (initializer, pp_tlib, p_index)
		end

	local_release_type_attr is
			-- No description available.
		do
			ccom_local_release_type_attr (initializer)
		end

	local_release_func_desc is
			-- No description available.
		do
			ccom_local_release_func_desc (initializer)
		end

	local_release_var_desc is
			-- No description available.
		do
			ccom_local_release_var_desc (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_itype_info_2_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_remote_get_type_attr (cpp_obj: POINTER; pp_type_attr: CELL [TAG_TYPEATTR_RECORD]; p_dummy: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_get_type_comp (cpp_obj: POINTER; pp_tcomp: CELL [ITYPE_COMP_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_remote_get_func_desc (cpp_obj: POINTER; a_index: INTEGER; pp_func_desc: CELL [TAG_FUNCDESC_RECORD]; p_dummy: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_remote_get_var_desc (cpp_obj: POINTER; a_index: INTEGER; pp_var_desc: CELL [TAG_VARDESC_RECORD]; p_dummy: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_remote_get_names (cpp_obj: POINTER; memid: INTEGER; rg_bstr_names: CELL [STRING]; c_max_names: INTEGER; pc_names: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_get_ref_type_of_impl_type (cpp_obj: POINTER; a_index: INTEGER; p_ref_type: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_get_impl_type_flags (cpp_obj: POINTER; a_index: INTEGER; p_impl_type_flags: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_local_get_ids_of_names (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_local_invoke (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_remote_get_documentation (cpp_obj: POINTER; memid: INTEGER; ref_ptr_flags: INTEGER; p_bstr_name: CELL [STRING]; p_bstr_doc_string: CELL [STRING]; pdw_help_context: INTEGER_REF; p_bstr_help_file: CELL [STRING]) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_remote_get_dll_entry (cpp_obj: POINTER; memid: INTEGER; invkind: INTEGER; ref_ptr_flags: INTEGER; p_bstr_dll_name: CELL [STRING]; p_bstr_name: CELL [STRING]; pw_ordinal: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_get_ref_type_info (cpp_obj: POINTER; hreftype: INTEGER; pp_tinfo: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_local_address_of_member (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_remote_create_instance (cpp_obj: POINTER; riid: POINTER; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](GUID *,EIF_OBJECT)"
		end

	ccom_get_mops (cpp_obj: POINTER; memid: INTEGER; p_bstr_mops: CELL [STRING]) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_remote_get_containing_type_lib (cpp_obj: POINTER; pp_tlib: CELL [ITYPE_LIB_2_INTERFACE]; p_index: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_local_release_type_attr (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_local_release_func_desc (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_local_release_var_desc (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_delete_itype_info_2_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]()"
		end

	ccom_create_itype_info_2_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::ITypeInfo_2_impl_proxy %"ecom_control_library_ITypeInfo_2_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- ITYPE_INFO_2_IMPL_PROXY

