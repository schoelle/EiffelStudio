indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANTS_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local
			internal_pixmap: EV_PIXMAP
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
			create l_vertical_box_1
			create l_horizontal_box_1
			create l_frame_1
			create l_vertical_box_2
			create constants_list
			create l_horizontal_box_2
			create display_all_types
			create l_horizontal_box_3
			create type_combo_box
			create string_item
			create integer_item
			create directory_item
			create name_field
			create entry_selection_parent
			create l_cell_1
			create l_horizontal_box_4
			create l_cell_2
			create add_button
			create remove_button
			create l_vertical_box_3
			create ok_button
			create l_cell_3
			create internal_pixmap
			
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_frame_1)
			l_frame_1.extend (l_vertical_box_2)
			l_vertical_box_2.extend (constants_list)
			l_vertical_box_2.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (display_all_types)
			l_vertical_box_2.extend (l_horizontal_box_3)
			l_horizontal_box_3.extend (type_combo_box)
			type_combo_box.extend (string_item)
			type_combo_box.extend (integer_item)
			type_combo_box.extend (directory_item)
			l_horizontal_box_3.extend (name_field)
			l_horizontal_box_3.extend (entry_selection_parent)
			l_vertical_box_2.extend (l_cell_1)
			l_vertical_box_2.extend (l_horizontal_box_4)
			l_horizontal_box_4.extend (l_cell_2)
			l_horizontal_box_4.extend (add_button)
			l_horizontal_box_4.extend (remove_button)
			l_horizontal_box_1.extend (l_vertical_box_3)
			l_vertical_box_3.extend (ok_button)
			l_vertical_box_3.extend (l_cell_3)
			
			set_title ("Constants")
			l_vertical_box_1.set_padding_width (10)
			l_vertical_box_1.set_border_width (5)
			l_horizontal_box_1.disable_item_expand (l_vertical_box_3)
			l_frame_1.set_text ("Constants Defined")
			l_vertical_box_2.set_border_width (2)
			l_vertical_box_2.disable_item_expand (l_horizontal_box_2)
			l_vertical_box_2.disable_item_expand (l_horizontal_box_3)
			l_vertical_box_2.disable_item_expand (l_cell_1)
			l_vertical_box_2.disable_item_expand (l_horizontal_box_4)
			display_all_types.enable_select
			display_all_types.set_text ("Show all types")
			l_horizontal_box_3.set_padding_width (5)
			type_combo_box.set_text ("DIRECTORY")
			type_combo_box.set_minimum_width (80)
			type_combo_box.disable_edit
			string_item.set_text ("STRING")
			integer_item.set_text ("INTEGER")
			directory_item.enable_select
			directory_item.set_text ("DIRECTORY")
			l_cell_1.set_minimum_height (5)
			l_horizontal_box_4.set_padding_width (5)
			l_horizontal_box_4.disable_item_expand (add_button)
			l_horizontal_box_4.disable_item_expand (remove_button)
			add_button.disable_sensitive
			add_button.set_text ("Add")
			add_button.set_minimum_width (80)
			remove_button.disable_sensitive
			remove_button.set_text ("Remove")
			remove_button.set_minimum_width (80)
			l_vertical_box_3.set_padding_width (5)
			l_vertical_box_3.set_border_width (4)
			l_vertical_box_3.disable_item_expand (ok_button)
			ok_button.set_text ("OK")
			ok_button.set_minimum_width (80)
			internal_pixmap.set_with_named_file (constant_by_name ("pixmap_location") + "\button_images.bmp")
			l_cell_3.set_background_pixmap (internal_pixmap)
			
			constants_list.select_actions.extend (agent item_selected_in_list (?))
			constants_list.deselect_actions.extend (agent item_deselected_in_list (?))
			constants_list.column_title_click_actions.extend (agent column_clicked (?))
			display_all_types.select_actions.extend (agent display_all_types_changed)
			string_item.select_actions.extend (agent string_item_selected)
			integer_item.select_actions.extend (agent integer_item_selected)
			directory_item.select_actions.extend (agent directory_item_selected)
			name_field.change_actions.extend (agent validate_constant_name)
			add_button.select_actions.extend (agent add_constant)
			remove_button.select_actions.extend (agent remove_selected_constant)
			ok_button.select_actions.extend (agent ok_pressed)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)

				-- Call `user_initialization'.
			user_initialization
		end
feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	l_vertical_box_1, l_vertical_box_2, l_vertical_box_3: EV_VERTICAL_BOX
	l_horizontal_box_1, l_horizontal_box_2, l_horizontal_box_3, l_horizontal_box_4: EV_HORIZONTAL_BOX
	l_frame_1: EV_FRAME
	constants_list: EV_MULTI_COLUMN_LIST
	display_all_types: EV_CHECK_BUTTON
	type_combo_box: EV_COMBO_BOX
	string_item, integer_item, directory_item: EV_LIST_ITEM
	name_field: EV_TEXT_FIELD
	entry_selection_parent, l_cell_1, l_cell_2, l_cell_3: EV_CELL
	add_button, remove_button, ok_button: EV_BUTTON
	
	item_selected_in_list (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `select_actions' of `constants_list'.
		deferred
		end
	
	item_deselected_in_list (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `deselect_actions' of `constants_list'.
		deferred
		end
	
	column_clicked (a_column: INTEGER) is
			-- Called by `column_title_click_actions' of `constants_list'.
		deferred
		end
	
	display_all_types_changed is
			-- Called by `select_actions' of `display_all_types'.
		deferred
		end
	
	string_item_selected is
			-- Called by `select_actions' of `string_item'.
		deferred
		end
	
	integer_item_selected is
			-- Called by `select_actions' of `integer_item'.
		deferred
		end
	
	directory_item_selected is
			-- Called by `select_actions' of `directory_item'.
		deferred
		end
	
	validate_constant_name is
			-- Called by `change_actions' of `name_field'.
		deferred
		end
	
	add_constant is
			-- Called by `select_actions' of `add_button'.
		deferred
		end
	
	remove_selected_constant is
			-- Called by `select_actions' of `remove_button'.
		deferred
		end
	
	ok_pressed is
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	

end -- class GB_CONSTANTS_DIALOG_IMP
