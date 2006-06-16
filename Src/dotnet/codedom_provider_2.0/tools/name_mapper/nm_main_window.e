indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NM_MAIN_WINDOW

inherit
	NM_MAIN_WINDOW_IMP
		rename
			put as window_put,
			has as window_has
		end

	NM_REFERENCED_ASSEMBLIES_MANAGER
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	NM_SAVED_SETTINGS
		rename
			make as saved_make
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create {ARRAYED_LIST [STRING]} dotnet_member_names.make (0)
			create members_mapping.make (0)
			create class_finder.make
			saved_make
			default_create
		end
		
	user_initialization is
			-- Initialize instance.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			-- Disable logging
			config_values.put ("0", "log_level")
			close_request_actions.extend (agent on_close)
			input_type_combo_box.set_focus
			assemblies_list.set_column_titles (<<"Prefix", "Name", "Path">>)
			load_assemblies
			from
				Referenced_assemblies.start
			until
				Referenced_assemblies.after
			loop
				create l_row
				l_row.extend (Referenced_assemblies.item.assembly_prefix)
				l_row.extend (Referenced_assemblies.item.assembly.get_name.full_name)
				l_row.extend (Referenced_assemblies.item.assembly.location)
				assemblies_list.extend (l_row)
				Referenced_assemblies.forth
			end
			on_column_resize (1)
			set_width (Saved_width)
			set_height (Saved_height)
			set_x_position (saved_x_pos)
			set_y_position (saved_y_pos)
			(create {EV_ENVIRONMENT}).application.post_launch_actions.extend (agent initialize_combo (input_type_combo_box, Types_key))
		end

feature {NONE} -- Events Handling

	on_type_change is
			-- Called by `change_actions' of `input_type_text_field'.
		local
			l_name: STRING
		do
			l_name := input_type_combo_box.text
			if l_name.is_empty then
				output_type_text_field.remove_text
				dotnet_member_names.wipe_out
				members_mapping.clear_all
			else
				if not class_finder.searching then
					output_type_text_field.set_foreground_color (Red)
					output_type_text_field.set_text ("Searching " + l_name + "...")
					add_button.disable_sensitive
							-- Do not enable add as it could cause weird threading problems
							-- when the add dialog appears
					class_finder.search (l_name)
					add_button.enable_sensitive
					output_type_text_field.set_foreground_color (Black)
					if class_finder.found then
						input_type_combo_box.set_foreground_color (Black)
						output_type_text_field.set_text (class_finder.eiffel_name)
						members_mapping := class_finder.members_mapping
						dotnet_member_names := class_finder.dotnet_member_names
						add_entry_to_combo_and_save (l_name, input_type_combo_box)
						fill_combo (input_member_combo_box, class_finder.dotnet_member_names)
					else
						output_type_text_field.remove_text
					end
				end
				if class_finder.searching or not class_finder.found then
					input_type_combo_box.set_foreground_color (Red)
					dotnet_member_names.wipe_out
					members_mapping.clear_all
				end
			end
			on_member_change
		end
	
	on_member_change is
			-- Called by `change_actions' of `input_feature_text_field'.
		local
			l_name, l_completion_name, l_dotnet_name: STRING
			l_car_pos: INTEGER
			l_found: BOOLEAN
		do
			l_name := input_member_combo_box.text
			if l_name.is_empty then
				output_member_text_field.remove_text
			else
				members_mapping.search (l_name)
				if members_mapping.found then
					output_member_text_field.set_text (members_mapping.found_item)
					input_member_combo_box.set_foreground_color (Black)
				else
					l_car_pos := input_member_combo_box.caret_position
					l_completion_name := l_name.substring (1, l_car_pos - 1)
					from
						dotnet_member_names.start
					until
						dotnet_member_names.after or l_found
					loop
						l_dotnet_name := dotnet_member_names.item
						l_found := l_dotnet_name.substring_index (l_completion_name, 1) = 1
						if l_found then
							input_member_combo_box.set_text (l_dotnet_name)
							input_member_combo_box.set_caret_position (l_car_pos)
							input_member_combo_box.set_foreground_color (Black)
						else
							dotnet_member_names.forth
						end
					end
					if not l_found then
						output_member_text_field.remove_text
						input_member_combo_box.set_foreground_color (Red)
					end
				end
			end
		end

	on_assembly_select (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Enable `Remove' button if not a default assembly.
		do
			if not is_startup_assembly (an_item.i_th (3)) then
				if not remove_button.is_sensitive then
					remove_button.enable_sensitive
				end
			else
				if remove_button.is_sensitive then
					remove_button.disable_sensitive
				end
			end
		end

	on_assembly_deselect (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `deselect_actions' of `assemblies_list'.
		do
			remove_button.disable_sensitive
		end

	on_add_assembly is
			-- Open file browse dialog and add selected assembly.
		local
			l_dialog: NM_NEW_REFERENCE_DIALOG
		do
			create l_dialog
			l_dialog.show_modal_to_window (Current)
			if l_dialog.assembly /= Void and then not l_dialog.assembly.is_empty then
				add_assembly (l_dialog.assembly, l_dialog.assembly_prefix)
				save_assemblies
			end
		end

	on_remove_assembly is
			-- Remove selected assembly
		local
			l_assembly_path, l_location: STRING
		do
			if assemblies_list.selected_item /= Void then
				l_assembly_path	:= assemblies_list.selected_item.i_th (3).as_lower
				if l_assembly_path /= Void then
					from
						Referenced_assemblies.start
					until
						Referenced_assemblies.after
					loop
						l_location := Referenced_assemblies.item.assembly.location
						if l_location.as_lower.is_equal (l_assembly_path) then
							Referenced_assemblies.remove
							Referenced_assemblies.finish
							from
								assemblies_list.start
							until
								assemblies_list.after
							loop
								if assemblies_list.item.i_th (3).as_lower.is_equal (l_assembly_path) then
									assemblies_list.remove
									assemblies_list.finish
								end
								assemblies_list.forth
							end
						end
						Referenced_assemblies.forth						
					end
				end
			end
			save_assemblies
		end

	on_column_resize (a_column: INTEGER) is
			-- Make sure second column always take up rest of space
		do
			if a_column /= 3 then
				assemblies_list.set_column_width (assemblies_list.width - assemblies_list.column_width (1) - assemblies_list.column_width (2), 3)
			end
		end

	on_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Make sure second column always take up rest of space
		do
			on_column_resize (1)
		end
	
	on_close is
			-- Save settings then close.
		do
			save_height (height)
			save_width (width)
			save_x_pos (x_position)
			save_y_pos (y_position)
			((create {EV_ENVIRONMENT}).application).destroy
		end
		
	on_about is
			-- Called by `select_actions' of `about_menu_item'.
		local
			l_about_dialog: NM_ABOUT_DIALOG
		do
			create l_about_dialog
			l_about_dialog.show_modal_to_window (Current)
		end

	on_help is
			-- Called by `select_actions' of `help_menu_item'.
		do
			(create {EV_ENVIRONMENT}).application.display_help_for_widget (Current)
		end

feature {NONE} -- Implementation

	add_assembly (a_assembly_path, a_prefix: STRING) is
			-- Add assembly at `a_assembly_path' to `assemblies_list'.
		require
			non_void_path: a_assembly_path /= Void
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_asm: ASSEMBLY
			l_retried: BOOLEAN
			l_error_dialog: EV_MESSAGE_DIALOG
		do
			if not l_retried then
				if not Referenced_assemblies.has_file (a_assembly_path) then
					l_asm := {ASSEMBLY}.load_from (a_assembly_path)
					if l_asm /= Void then
						if a_prefix /= Void and then not a_prefix.is_empty then
							Referenced_assemblies.extend_file_with_prefix (a_assembly_path, a_prefix)
						else
							Referenced_assemblies.extend_file (a_assembly_path)
						end
						if Referenced_assemblies.assembly_added then
							create l_row
							l_row.extend ("")
							l_row.extend (l_asm.get_name.full_name)
							l_row.extend (a_assembly_path)
							assemblies_list.extend (l_row)
						end
					end
				end
			end
		rescue
			create l_error_dialog.make_with_text ("Could not add assembly reference, caught the following exception:%N%N" + {ISE_RUNTIME}.last_exception.message)
			l_error_dialog.set_title ("Add Reference Error")
			l_error_dialog.set_buttons (<<"Cancel">>)
			l_error_dialog.set_pixmap (Default_pixmaps.error_pixmap)
			l_error_dialog.show_modal_to_window (Current)
			l_retried := True
			retry
		end
		
feature {NONE} -- Private Access

	class_finder: NM_CLASS_FINDER
			-- Class finder

	members_mapping: HASH_TABLE [STRING, STRING]
			-- Table of member names mapping
			-- Indexed by .NET member names

	dotnet_member_names: LIST [STRING]
			-- Sorted list of current .NET member names

	Black: EV_COLOR is
			-- Black
		once
			Result := (create {EV_STOCK_COLORS}).Black
		end
		
	Red: EV_COLOR is
			-- Red
		once
			Result := (create {EV_STOCK_COLORS}).Red
		end

invariant
	non_void_dotnet_member_names: dotnet_member_names /= Void

indexing
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
end -- class NM_MAIN_WINDOW

