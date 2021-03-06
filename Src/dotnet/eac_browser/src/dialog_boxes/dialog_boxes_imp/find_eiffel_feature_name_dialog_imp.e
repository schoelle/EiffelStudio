note
	description: "Objects that represent an EV_TITLED_WINDOW generated by Build."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FIND_EIFFEL_FEATURE_NAME_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			
				-- Create all widgets.
			create l_vertical_box_1
			create l_vertical_box_2
			create l_horizontal_box_1
			create l_label_1
			create l_label_2
			create eiffel_class_name
			create l_label_3
			create l_vertical_box_3
			create l_label_4
			create l_horizontal_box_2
			create l_label_5
			create search_btn
			create l_label_6
			create cancel_btn
			create l_label_7
			
				-- Build_widget_structure.
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_vertical_box_2)
			l_vertical_box_2.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_label_1)
			l_horizontal_box_1.extend (l_label_2)
			l_horizontal_box_1.extend (eiffel_class_name)
			l_horizontal_box_1.extend (l_label_3)
			l_vertical_box_1.extend (l_vertical_box_3)
			l_vertical_box_3.extend (l_label_4)
			l_vertical_box_1.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (l_label_5)
			l_horizontal_box_2.extend (search_btn)
			l_horizontal_box_2.extend (l_label_6)
			l_horizontal_box_2.extend (cancel_btn)
			l_horizontal_box_2.extend (l_label_7)
			
				-- Initialize properties of all widgets.
			set_minimum_width (240)
			set_minimum_height (85)
			set_title ("Find Eiffel class in Eiffel Assembly Cache")
			l_label_2.set_text ("Eiffel class name:")
			l_label_2.align_text_left
			l_horizontal_box_2.disable_item_expand (search_btn)
			l_horizontal_box_2.disable_item_expand (cancel_btn)
			search_btn.set_text ("Search")
			cancel_btn.set_text ("Cancel")
			
				--Connect events.
			eiffel_class_name.key_press_actions.extend (agent on_enter (?))
			search_btn.select_actions.extend (agent on_search)
			cancel_btn.select_actions.extend (agent on_cancel)

				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)

			user_initialization
		end


feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	l_vertical_box_1, l_vertical_box_2, l_vertical_box_3: EV_VERTICAL_BOX
	l_horizontal_box_1, l_horizontal_box_2: EV_HORIZONTAL_BOX
	l_label_1, l_label_2, l_label_3, l_label_4, l_label_5, l_label_6, l_label_7: EV_LABEL
	eiffel_class_name: EV_TEXT_FIELD
	search_btn, cancel_btn: EV_BUTTON
	
	user_initialization
			-- Called by `select_actions' of `execute'.
		deferred
		end

	on_enter (a_key: EV_KEY)
			-- Called by `key_press_actions' of `eiffel_class_name'.
		deferred
		end

	on_search
			-- Called by `pointer_enter_actions' of `eiffel_class_name'.
		deferred
		end
	
	on_cancel
			-- Called by `select_actions' of `cancel_btn'.
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


end -- class FIND_EIFFEL_FEATURE_NAME_DIALOG
