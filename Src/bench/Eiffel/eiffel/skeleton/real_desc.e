indexing
	description: "Real description"
	date: "$Date$"
	revision: "$Revision$"

class REAL_DESC 

inherit
	ATTR_DESC
		rename
			Real_level as level,
			Float_c_type as type_i
		end

feature -- Access

	sk_value: INTEGER is
		do
			Result := Sk_float
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ("SK_FLOAT")
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[REAL]")
		end

end
