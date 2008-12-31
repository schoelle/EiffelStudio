note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_DATA

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end

feature -- Access		


	output_directory: STRING
			--
		do
			Result := output_directory_preference.value
		end

feature {NONE} -- Preferences

	output_directory_preference: STRING_PREFERENCE
			-- Current text font.

feature {NONE} -- Preference Strings

	output_directory_string: STRING = "general.output_directory"

feature {NONE} -- Implementation
		
	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: PREFERENCE_MANAGER		
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			l_manager := preferences.new_manager ("general")

				-- Preferences
				
			output_directory_preference := l_factory.new_string_resource_value (l_manager, output_directory_string, current_working_directory)	
		end

	preferences: PREFERENCES;
			-- Preferences

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
