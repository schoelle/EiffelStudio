indexing
	description: "Implemented `IPropertyBag' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPROPERTY_BAG_IMPL_STUB

inherit
	IPROPERTY_BAG_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	remote_read (psz_prop_name: STRING; p_var: ECOM_VARIANT; p_error_log: IERROR_LOG_INTERFACE; var_type: INTEGER; p_unk_obj: ECOM_INTERFACE) is
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_var' [out].  
			-- `p_error_log' [in].  
			-- `var_type' [in].  
			-- `p_unk_obj' [in].  
		do
			-- Put Implementation here.
		end

	write (psz_prop_name: STRING; p_var: ECOM_VARIANT) is
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_var' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IPROPERTY_BAG_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IPropertyBag_impl_stub %"ecom_control_library_IPropertyBag_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IPROPERTY_BAG_IMPL_STUB

