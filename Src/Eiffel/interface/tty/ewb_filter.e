note

	description:
		"Build a filtered version (troff, ..) of some text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FILTER

feature -- Initialization

	init (fn: like filter_name)
			-- Initialize Current filter_name as `fn'.
		require
			fn_not_void: fn /= Void
		do
			filter_name := fn
		ensure
			filter_set: filter_name = fn
		end;

feature -- Properties

	filter_name: STRING_32
			-- Name of the filter to be used

feature {NONE} -- Execution

	associated_cmd: E_OUTPUT_CMD
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		deferred
		ensure
			non_void_result: Result /= Void
		end;

	loop_action
			-- Execute Current command from loop.
		deferred
		end;

note
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

end -- class EWB_FILTER
