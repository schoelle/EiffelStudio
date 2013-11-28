﻿note
	description: "Error in loop iteration part: missing required feature."

class LOOP_ITERATION_NO_FEATURE_ERROR

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			help_file_name
		end

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; f: STRING; i: CLASS_C; l: LOCATION_AS)
			-- Create error object for loop iteration that cannot find a feature `f' in class `i' in the context `c'.
		require
			c_attached: attached c
			f_attached: attached f
			i_attached: attached i
			l_attached: attached l
		do
			c.init_error (Current)
			missing_feature_name := f
			iteration_class := i
			set_location (l)
		ensure
			missing_feature_name_set: missing_feature_name = f
			iteration_class_set: iteration_class = i
		end

feature -- Error properties

	code: STRING = "Loop iteration no feature error"
			-- Error code.

	help_file_name: STRING_8 = "Loop_iteration_no_feature_error"
			-- Help file name.

feature {NONE} -- Access

	iteration_class: CLASS_C
			-- Affected iteration class.

	missing_feature_name: STRING_32
			-- Name of the missing feature.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_text_formatter.add ("Class: ")
			iteration_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Missing feature: ")
			a_text_formatter.add (missing_feature_name)
			a_text_formatter.add_new_line
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
