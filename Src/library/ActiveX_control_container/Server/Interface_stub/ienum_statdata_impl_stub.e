indexing
	description: "Implemented `IEnumSTATDATA' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IENUM_STATDATA_IMPL_STUB

inherit
	IENUM_STATDATA_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	remote_next (celt: INTEGER; rgelt: TAG_STATDATA_RECORD; pcelt_fetched: INTEGER_REF) is
			-- No description available.
			-- `celt' [in].  
			-- `rgelt' [out].  
			-- `pcelt_fetched' [out].  
		do
			-- Put Implementation here.
		end

	skip (celt: INTEGER) is
			-- No description available.
			-- `celt' [in].  
		do
			-- Put Implementation here.
		end

	reset is
			-- No description available.
		do
			-- Put Implementation here.
		end

	clone1 (ppenum: CELL [IENUM_STATDATA_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IENUM_STATDATA_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IEnumSTATDATA_impl_stub %"ecom_control_library_IEnumSTATDATA_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IENUM_STATDATA_IMPL_STUB

