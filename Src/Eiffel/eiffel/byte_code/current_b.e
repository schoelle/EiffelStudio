note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Access to Current

class CURRENT_B

inherit

	ACCESS_B
		redefine
			enlarged, is_current,
			register_name, pre_inlined_code, print_register,
			is_fast_as_local
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_current_b (Current)
		end

feature

	type: LIKE_CURRENT
			-- Current type
		do
			create Result.make (context.current_type)
				-- Current is always attached
			Result.set_attached_mark
				-- Current is always frozen
			Result.set_frozen_mark
		end

	is_current: BOOLEAN
			-- This is an access to Current
		do
			Result := True
		end

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		local
			current_b: CURRENT_B;
		do
			current_b ?= other;
			Result := current_b /= Void
		end;

	enlarged: CURRENT_B
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			create {CURRENT_BL} Result;
		end;

	register_name: STRING
			-- The "Current" string
		once
			Result := "Current";
		end;

	print_register
			-- Print "Current" register
		do
			context.buffer.put_string (register_name)
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN = true
			-- Is expression calculation as fast as loading a local?

feature -- Inlining

	pre_inlined_code: CURRENT_B
		do
			create {INLINED_CURRENT_B} Result
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
