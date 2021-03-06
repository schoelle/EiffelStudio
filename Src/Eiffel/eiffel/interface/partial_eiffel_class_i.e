note
	description:
		"Internal representation of a class built of partial classes. Instance of CLASS_I represent%
		%non-compiled classes, but instance of CLASS_C already compiled%
		%classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	PARTIAL_EIFFEL_CLASS_I

inherit
	EIFFEL_CLASS_I
		undefine
			is_read_only,
			full_file_name,
			check_changed
		redefine
			class_type,
			cluster,
			file_name
		end

	CONF_CLASS_PARTIAL
		rename
			file_name as base_name,
			group as cluster
		undefine
			check_changed_options, invalidate, is_compiled, options, rebuild
		redefine
			class_type,
			cluster
		end

create {CONF_FACTORY}
	make_from_partial

feature -- Access

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to.

	file_name: PATH
			-- Full file name of the class.
		do
			Result := base_location.build_path (path, base_name)
		end

feature {NONE} -- Type anchor

	class_type: PARTIAL_EIFFEL_CLASS_I
			-- <Precursor>
		do
		end

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
end
