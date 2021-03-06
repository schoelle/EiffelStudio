note
	description: "Facility routines to check the validity of DATE_TIMEs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATE_TIME_VALIDITY_CHECKER

inherit
	DATE_VALIDITY_CHECKER
		export
			{NONE} all
		end

	TIME_VALIDITY_CHECKER
		export
			{NONE} all
		end

	ANY

feature -- Preconditions

	date_time_valid (s: STRING; code_string: STRING): BOOLEAN
			-- Is the code_string enough precise
			-- To create an instance of type DATE_TIME
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			Result := code.precise and code.correspond (s) and then
				code.is_date_time (s)
		end

	date_time_valid_with_base (s: STRING; code_string: STRING;
					base: INTEGER): BOOLEAN
			-- Is the code_string enough precise
			-- To create an instance of type DATE_TIME
			-- And does the string `s' correspond to `code_string'?
			-- Use base century `base'.
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			code.set_base_century (base)
			Result := code.precise and code.correspond (s) and then
				code.is_date_time (s)
		end

	is_correct_date_time (y, mo, d, h, mi: INTEGER; s: DOUBLE;
					 	  twelve_hour_scale: BOOLEAN): BOOLEAN
			-- Is date-time specified by `y', `mo', `d', `h', `mi', `s'
			-- correct?
			-- `twelve_hour_scale' specifies if the hour range is 1 - 12
			-- (if True) or 0 - 23 (if False).
		do
			Result := is_correct_date (y, mo, d) and
				is_correct_time (h, mi, s, twelve_hour_scale)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATE_TIME_VALIDITY_CHECKER


