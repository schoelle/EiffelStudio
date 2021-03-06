note
	description: "[
		It is not recommended to use unless you know you are working with a focused window, or need access to shared
		tool resources that do not rely on the window itself.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_TOOL_MINI_ICONS_PROVIDER [G -> ES_TOOL_PIXMAPS create make end, T -> ES_TOOL [EB_TOOL]]

inherit
	ES_TOOL_MINI_ICONS_PROVIDER_I [G, T]

	ES_TOOL_PROVIDER [T]
		rename
			make as tool_provider_make
		redefine
			window
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: attached like window)
			-- Initializes the icon provider using a
		require
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			window := a_window
		ensure
			window_set: window = a_window
		end

feature {NONE} -- Access

	window: attached EB_DEVELOPMENT_WINDOW
			-- <Precursor>

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
