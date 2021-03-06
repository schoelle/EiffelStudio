note
	description: "Testing class to benchmark the speed of the Eiffel parser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_PARSER_TESTER

feature -- Basic Operations

	run_test (a_parser: TEST_EIFFEL_PARSER; a_source: STRING; a_source_id: STRING; a_error: NATURAL_8): PARSE_TEST_RESULT
			-- Run parser test on source test `a_source', using parser `a_parser', with initialized parser and return a test result.
			-- `a_error' dictates how many parses to perform. `a_frozen' indicates to test frozen parser also.
		require
			a_parser_attached: a_parser /= Void
			a_source_id_attached: a_source_id /= Void
			not_a_source_id_is_empty: not a_source_id.is_empty
			a_a_source_id_attached: a_source_id /= Void
			not_a_source_id_is_empty: not a_source_id.is_empty
			a_error_positive: a_error > 0
		local
			l_ticks: REAL_64
			i: INTEGER
		do
			start_time.make_now
			from i := 0 until i = a_error loop
				a_parser.parse (a_source)
				i := i + 1
			end
			end_time.make_now
			l_ticks := (end_time.relative_duration (start_time).fine_seconds_count) / a_error
			create Result.make (a_source_id, l_ticks, a_parser.successful, a_parser.identity)
		ensure
			result_attached: Result /= Void
		end

	run_test_with_file (a_parser: TEST_EIFFEL_PARSER; a_fn: STRING; a_error: NATURAL_8): PARSE_TEST_RESULT
			-- Run parser test on file `a_fn', using parser `a_parser', with initialized parser and return a test result.
			-- `a_error' dictates how many parses to perform. `a_frozen' indicates to test frozen parser also.
		require
			a_parser_attached: a_parser /= Void
			a_fn_attached: a_fn /= Void
			not_a_fn_is_empty: not a_fn.is_empty
			a_fn_exists: (create {RAW_FILE}.make (a_fn)).exists
			a_error_positive: a_error > 0
		local
			l_ticks: REAL_64
			i: INTEGER
		do
			start_time.make_now
			from i := 0 until i = a_error loop
				a_parser.parse_file (a_fn)
				i := i + 1
			end
			end_time.make_now
			l_ticks := (end_time.relative_duration (start_time).fine_seconds_count) / a_error
			create Result.make (a_fn, l_ticks, a_parser.successful, a_parser.identity)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Timing

	start_time, end_time: TIME
			-- Time used for computation
		once
			create Result.make_now
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class {EIFFEL_PARSER_TESTER}
