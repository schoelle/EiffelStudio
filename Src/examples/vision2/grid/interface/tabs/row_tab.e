indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	ROW_TAB

inherit
	ROW_TAB_IMP
	
	GRID_ACCESSOR
		undefine
			copy, default_create, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			current_row_index := 1
			row_finder.set_prompt ("Row Finder : ")
			row_finder.motion_actions.extend (agent row_motion)
			move_to_row_finder.motion_actions.extend (agent move_to_row_motion)
			move_to_row_finder.set_prompt ("Locate Row : ")
			add_default_colors_to_combo (foreground_color_combo)
			add_default_colors_to_combo (background_color_combo)
		end

feature {NONE} -- Implementation

	current_row_index: INTEGER
			-- Current index of row for property change.

	move_to_row_motion (an_item: EV_GRID_ITEM) is
			--
		do
			fixme ("ROW_TAB.move_to_row_motion Must add preconditions based on those of `move_row'.")
			if an_item /= Void then
				current_move_to_row_index := an_item.row.index
			else
				current_move_to_row_index := 0
			end
			swap_row_button.set_text ("Move Row " + current_row_index.out + " past Row " + current_past_row)
		end

	current_move_to_row_index: INTEGER
			-- Currently selected row index for the move row button.
		
	row_motion (an_item: EV_GRID_ITEM) is
			--
		local
			l_row: EV_GRID_ROW
			l_color: EV_COLOR
		do
			if an_item /= Void then
				l_row := an_item.row
				row_properties_frame.enable_sensitive
				row_operations_frame.enable_sensitive
				row_index_entry.change_actions.block
				row_index_entry.set_value (an_item.row.index)
				row_index_entry.change_actions.resume
				current_row_index := l_row.index
				if grid.is_row_height_fixed then
					row_height_entry.disable_sensitive
					row_height_entry.change_actions.block
					row_height_entry.set_value (grid.row_height)
					row_height_entry.change_actions.resume
				else
					row_height_entry.enable_sensitive
					row_height_entry.change_actions.block
					row_height_entry.set_value (an_item.row.height)
					row_height_entry.change_actions.resume
				end
				row_selected_button.select_actions.block
				if an_item.row.is_selected then
					row_selected_button.enable_select
				else
					row_selected_button.disable_select
				end
				row_selected_button.select_actions.resume
				swap_row_button.set_text ("Move Row " + l_row.index.out + " past Row " + current_past_row)
				if l_row.parent_row /= Void and l_row.index + l_row.subrow_count_recursive = l_row.parent_row_root.index + l_row.parent_row_root.subrow_count_recursive then
						-- We check that the row may actually be removed. Note the you may not unparent a row within the
						-- middle of a tree structure.
					unparent_row_button.enable_sensitive
				else
					unparent_row_button.disable_sensitive
				end
				background_color_combo.select_actions.block
				if l_row.background_color /= Void then
					from
						background_color_combo.start
					until
						background_color_combo.off
					loop
						l_color ?= background_color_combo.item.data		
						if l_color /= Void and then l_color.is_equal (l_row.background_color) then
							background_color_combo.item.enable_select
							background_color_combo.go_i_th (background_color_combo.count)
						end
						background_color_combo.forth
					end
				else
					background_color_combo.first.enable_select
				end
				background_color_combo.select_actions.resume
				foreground_color_combo.select_actions.block
				if l_row.foreground_color /= Void then
					from
						foreground_color_combo.start
					until
						foreground_color_combo.off
					loop
						l_color ?= foreground_color_combo.item.data		
						if l_color /= Void and then l_color.is_equal (l_row.foreground_color) then
							foreground_color_combo.item.enable_select
							foreground_color_combo.go_i_th (foreground_color_combo.count)
						end
						foreground_color_combo.forth
					end
				else
					foreground_color_combo.first.enable_select
				end
				foreground_color_combo.select_actions.resume
			else
				row_properties_frame.disable_sensitive
				row_operations_frame.disable_sensitive
				swap_row_button.set_text ("Move Row ? past Row " + current_past_row)
			end
		end
		
	row_index_entry_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `row_index_entry'.
		do
			current_row_index := a_value
			row_motion (grid.row (current_row_index).item (1))
		end
	
	row_height_entry_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `row_height_entry'.
		do
			check
				variable_row_heights: not grid.is_row_height_fixed
			end
			grid.row (current_row_index).set_height (a_value)
			print (grid.row (current_row_index).item (1).virtual_y_position)
		end
	
	row_selected_button_selected is
			-- Called by `select_actions' of `row_selected_button'.
		do
			if row_selected_button.is_selected then
				grid.row (current_row_index).enable_select
			else
				grid.row (current_row_index).disable_select
			end
		end

	current_past_row: STRING is
			-- Return a string indicating the selected row to move past.
		do
			if current_move_to_row_index = 0 then
				Result := "?"
			else
				Result := current_move_to_row_index.out
			end
		ensure
			result_not_void: Result /= Void
		end
		
	swap_row_button_selected is
			-- Called by `select_actions' of `swap_row_button'.
		do
			grid.move_row (current_row_index, current_move_to_row_index)
		end
		
	remove_row_button_selected is
			-- Called by `select_actions' of `remove_row_button'.
		do
			grid.remove_row (current_row_index)			
		end
		
	unparent_row_button_selected is
			-- Called by `select_actions' of `unparent_row_button'.
		do
			grid.row (current_row_index).parent_row.remove_subrow (grid.row (current_row_index))
			unparent_row_button.disable_sensitive
		end

	clear_row_button_selected is
			-- Called by `select_actions' of `clear_row_button'.
		do
			grid.row (current_row_index).clear
		end

	foreground_color_combo_selected is
			-- Called by `select_actions' of `foreground_color_combo'.
		local
			row: EV_GRID_ROW
			color: EV_COLOR
		do
			if current_row_index < grid.row_count then
				row := grid.row (current_row_index)
				if row /= Void then
					color ?= foreground_color_combo.selected_item.data
					row.set_foreground_color (color)
				end
			end
		end
	
	background_color_combo_selected is
			-- Called by `select_actions' of `background_color_combo'.
		local
			row: EV_GRID_ROW
			color: EV_COLOR
		do
			if current_row_index < grid.row_count then
				row := grid.row (current_row_index)
				if row /= Void then
					color ?= background_color_combo.selected_item.data
					row.set_background_color (color)
				end
			end
		end

end -- class ROW_TAB

