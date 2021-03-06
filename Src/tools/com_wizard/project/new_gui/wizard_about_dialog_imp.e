note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_ABOUT_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	WIZARD_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		local
			internal_font: EV_FONT
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create main_box
			create inside_box
			create left_box
			create left_top_padding_cell
			create es_logo_pixmap
			create left_bottom_padding_cell
			create right_box
			create title_label
			create version_box
			create version_title
			create version_label
			create content_box
			create copyright_label
			create web_address_label
			create l_ev_horizontal_separator_1
			create bottom_box
			create left_bottom_cell
			create ok_button
			create right_button_cell
			
				-- Build_widget_structure.
			extend (main_box)
			main_box.extend (inside_box)
			inside_box.extend (left_box)
			left_box.extend (left_top_padding_cell)
			left_box.extend (es_logo_pixmap)
			left_box.extend (left_bottom_padding_cell)
			inside_box.extend (right_box)
			right_box.extend (title_label)
			right_box.extend (version_box)
			version_box.extend (version_title)
			version_box.extend (version_label)
			right_box.extend (content_box)
			content_box.extend (copyright_label)
			content_box.extend (web_address_label)
			main_box.extend (l_ev_horizontal_separator_1)
			main_box.extend (bottom_box)
			bottom_box.extend (left_bottom_cell)
			bottom_box.extend (ok_button)
			bottom_box.extend (right_button_cell)
			
			main_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			main_box.disable_item_expand (l_ev_horizontal_separator_1)
			inside_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			inside_box.disable_item_expand (left_box)
			inside_box.disable_item_expand (right_box)
			left_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			left_box.disable_item_expand (es_logo_pixmap)
			left_top_padding_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			es_logo_pixmap.set_minimum_width (182)
			es_logo_pixmap.set_minimum_height (80)
			es_logo_pixmap.copy (eiffel_software_png)
			left_bottom_padding_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			right_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			right_box.set_padding_width (10)
			right_box.set_border_width (10)
			right_box.disable_item_expand (title_label)
			right_box.disable_item_expand (version_box)
			right_box.disable_item_expand (content_box)
			title_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			create internal_font
			internal_font.set_family ({EV_FONT_CONSTANTS}.Family_sans)
			internal_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			internal_font.set_shape ({EV_FONT_CONSTANTS}.Shape_regular)
			internal_font.set_height_in_points (12)
			internal_font.preferred_families.extend ("Trebuchet MS")
			title_label.set_font (internal_font)
			title_label.set_text ("EiffelCOM Wizard")
			version_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			version_box.disable_item_expand (version_title)
			version_title.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			version_title.set_text ("v")
			version_title.align_text_left
			version_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			version_label.set_text ("2.0.0228")
			version_label.align_text_left
			content_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			content_box.set_padding_width (5)
			copyright_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			copyright_label.set_text ("Copyright (C) 2006 Eiffel Software")
			copyright_label.align_text_left
			web_address_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			web_address_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (64, 0, 128))
			web_address_label.set_text ("http://www.eiffel.com")
			web_address_label.align_text_left
			bottom_box.set_padding_width (5)
			bottom_box.set_border_width (7)
			bottom_box.disable_item_expand (ok_button)
			ok_button.set_text ("OK")
			ok_button.set_minimum_width (100)
			set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			disable_user_resize
			set_title ("EiffelCOM Wizard")
			
				--Connect events.
			web_address_label.pointer_button_release_actions.extend (agent on_web_click (?, ?, ?, ?, ?, ?, ?, ?))
			web_address_label.pointer_enter_actions.extend (agent on_mouse_enter)
			web_address_label.pointer_leave_actions.extend (agent on_mouse_leave)
			ok_button.select_actions.extend (agent on_ok)
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	es_logo_pixmap: EV_PIXMAP
	main_box, left_box, right_box, content_box: EV_VERTICAL_BOX
	inside_box, version_box,
	bottom_box: EV_HORIZONTAL_BOX
	title_label, version_title, version_label, copyright_label, web_address_label: EV_LABEL
	ok_button: EV_BUTTON
	left_top_padding_cell,
	left_bottom_padding_cell, left_bottom_cell, right_button_cell: EV_CELL

feature {NONE} -- Implementation

	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	on_web_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_button_release_actions' of `web_address_label'.
		deferred
		end
	
	on_mouse_enter
			-- Called by `pointer_enter_actions' of `web_address_label'.
		deferred
		end
	
	on_mouse_leave
			-- Called by `pointer_leave_actions' of `web_address_label'.
		deferred
		end
	
	on_ok
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	

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
end -- class WIZARD_ABOUT_DIALOG_IMP
