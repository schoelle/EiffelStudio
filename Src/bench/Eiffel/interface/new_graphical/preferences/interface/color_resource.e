indexing
 
	description:
		"A resource value for color resources."
	date: "$Date$"
	revision: "$Revision$"
 
class
	COLOR_RESOURCE 
 
inherit
	STRING_RESOURCE
		redefine
			set_value, make, get_value, xml_trace, registry_name
		end
 
creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := a_value
			if a_value /= Void then
				set_value (a_value)
			end
		end
 
feature -- Access

	actual_value: EV_COLOR is
			-- Color value of resource
		do
			create Result.make_with_rgb (r, g, b)
		end

	negative_value: EV_COLOR is
			-- Negative value of resource
		do
			create Result.make_with_rgb (1 - r, 1 - g, 1 - b)
		end

	valid_actual_value: EV_COLOR is
			-- Non void color value
		do
			Result := actual_value
			if Result = Void then
				Result := default_color
			end
		ensure
			valid_result: Result /= Void
		end

	default_color: EV_COLOR is
			-- Default color (Black)
		once
			create Result.make_with_rgb (0, 0, 0)
		end

	get_value: EV_COLOR is
		-- No use
		do
			Result := actual_value
		end

feature -- Status setting

	set_value_with_color (new_value: STRING; col: EV_COLOR) is
		require
			color_exists: col /= Void
			value_exists: new_value /= Void
		do
			value := new_value
			r := col.red
			g := col.green
			b := col.blue
		end

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		local
			s: STRING
			i: INTEGER
		do
			value := new_value
			s := clone (value)
			i := s.index_of(';', 1)
			if i > 0 then
				r := head_real (s, i - 1)
				s := s.substring (i + 1, s.count)
				i := s.index_of (';',1)
				if i > 0 then
					g := head_real (s, i - 1)
					s := s.substring (i + 1, s.count)
					b := head_real (s, s.count)
				else
					r := 0
					g := 0
					b := 0
				end
			else
				r := 0
				g := 0
				b := 0
			end
		end

feature {NONE} -- Implementation

	r, g, b: REAL

	head_real (s: STRING; i: INTEGER): REAL is
			-- Real represented by the `i' first characters of `s'
			-- Result is always in [0..1], being truncated if necessary.
			-- (Result is 0 if no integer is recognized)
		require
			not_void: s /= Void
			index_possible: i>0 and then i<=s.count	
		local
			s1: STRING
		do
			s1 := s.substring (1, i)
			if s1.is_real then
				Result := s1.to_real
			end
			if Result > 1 then
				Result := 1
			elseif Result < 0 then
				Result := 0
			end
		end

	head_integer (s: STRING; i: INTEGER): INTEGER is
			-- Integer represented by the `i' first characters of `s'
			-- Result is always in [0..255], being truncated if necessary.
			-- (Result is 0 if no integer is recognized)
		require
			not_void: s /= Void
			index_possible: i>0 and then i<=s.count	
		local
			s1: STRING
		do
			s1 := s.substring (1, i)
			if s1.is_integer then
				Result := s1.to_integer
			end
			if Result > 255 then
				Result := 255
			elseif Result < 0 then
				Result := 0
			end
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		do
			Result := "<TEXT>"
			Result.append (name)
			Result.append ("<COLOR>")
			Result.append (value)
			Result.append ("</COLOR></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFCOL_" + name
		end


end -- class COLOR_RESOURCE
