indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_ULARGE_INTEGER_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

creation
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	quad_part: INTEGER_64 is
			-- No description available.
		do
			Result := ccom_x_ularge_integer_quad_part (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x_ularge_integer
		end

feature -- Basic Operations

	set_quad_part (a_quad_part: INTEGER_64) is
			-- Set `quad_part' with `a_quad_part'.
		do
			ccom_x_ularge_integer_set_quad_part (item, a_quad_part)
		end

feature {NONE}  -- Externals

	c_size_of_x_ularge_integer: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library__ULARGE_INTEGER_s.h%"]"
		alias
			"sizeof(ecom_control_library::_ULARGE_INTEGER)"
		end

	ccom_x_ularge_integer_quad_part (a_pointer: POINTER): INTEGER_64 is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__ULARGE_INTEGER_s_impl.h%"](ecom_control_library::_ULARGE_INTEGER *):EIF_INTEGER_64"
		end

	ccom_x_ularge_integer_set_quad_part (a_pointer: POINTER; arg2: INTEGER_64) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__ULARGE_INTEGER_s_impl.h%"](ecom_control_library::_ULARGE_INTEGER *, ULONGLONG)"
		end

end -- X_ULARGE_INTEGER_RECORD

