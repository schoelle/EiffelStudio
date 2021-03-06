note
	description: "This class represents a MS_IMPpixmap button"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	PICT_COLOR_B_IMP

inherit
	OWNER_DRAW_BUTTON_WINDOWS
		redefine
			on_draw,
			set_default_size,
			set_background_pixmap,
			realize,
			on_left_button_up,
			on_left_button_down,
			on_lbutton_move,
			on_bn_clicked
		end
		
	PICT_COLOR_B_I

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_picture_color_button: PICT_COLOR_B; oui_parent: COMPOSITE; man: BOOLEAN)
			-- Create the pict color b
		do
			create private_attributes
			parent ?= oui_parent.implementation
			managed := True
			a_picture_color_button.set_font_imp (Current)
			managed := man
		end

feature -- Access

	pixmap: PIXMAP
			-- Pixmap to be drawn on button

	is_pressed: BOOLEAN
			-- Is the button pressed?

feature -- Status setting

	set_pressed (b: boolean)
			-- Set `is_pressed' to `b'. 
		do 
			is_pressed := b;
			if exists then
				invalidate
			end
		end

	set_pixmap, set_background_pixmap (a_pixmap: PIXMAP)
			-- Set the pixmap for the button
		do
			pixmap := a_pixmap
			if
				(fixed_size_flag and 
				(pixmap.height + Total_offset > height or pixmap.width + Total_offset > width))
				or not fixed_size_flag
			then
				set_form_width ((pixmap.width + Total_offset).min (maximal_width))
				set_form_height ((pixmap.height + Total_offset).min (maximal_height))
			end
			if exists then
				invalidate
			end
		end

	set_default_size
			-- Set default of button
		do
			if pixmap /= Void then
				set_form_width (pixmap.width + Total_offset)
				set_form_height (pixmap.height + Total_offset)
			end
		end

feature -- Element change 

	add_draw_item_action (a_command: COMMAND; arg: ANY)
			-- Action for a draw item.
		do
			draw_item_actions.add (Current, a_command, arg)
		end

	realize
		do
			Precursor{OWNER_DRAW_BUTTON_WINDOWS} ;
			invalidate
		end

feature -- Removal

	remove_draw_item_action (a_command: COMMAND; arg: ANY)
			-- Remove actions for draw_item event
		do
			draw_item_actions.remove (Current, a_command, arg)
		end

feature {NONE} -- Implementation

	on_lbutton_move (keys, x_pos, y_pos: INTEGER)
			-- Executed when the mouse moves with the left button dowm
			-- (from WIDGET_IMP)
			-- (export status {NONE})
		local
			cd: MOTNOT_DATA;
			wp: WEL_POINT;
			e_x, e_y: INTEGER;
			ww: WEL_WINDOW
		do
			create wp.make (x_pos, y_pos);
			ww ?= Current;
			wp.client_to_screen (ww);
			e_x := wp.x;
			e_y := wp.y;
			create cd.make (widget_oui, x_pos, y_pos, e_x, e_y, buttons_state);
			left_button_motion_actions.execute (Current, cd)
			if has_capture then
				if is_being_pressed and not in_button_area (x_pos, y_pos) then
					is_being_pressed := False
					if exists then
						invalidate
					end
				elseif not is_being_pressed and in_button_area (x_pos, y_pos) then
					is_being_pressed := True
					if exists then
						invalidate
					end
				end
			else
				is_being_pressed := False
				if exists then
					invalidate
				end
			end
		end

	on_left_button_down (keys, a_x, a_y: INTEGER)
			-- Wm_lbuttondown message
			-- See class WEL_IMPK_CONSTANTS for `keys' value
		local
			cd: BTPRESS_DATA;
			k: KEYBOARD_WINDOWS
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			create k.make_from_mouse_state (keys)
			create wp.make (a_x, a_y)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			left_button_down_implementation.set_item (true);
			left_button_down_widget_implementation.replace (Current);
			wel_set_capture
			is_being_pressed := True
			if exists then
				invalidate
			end
			create cd.make (owner, a_x, a_y, e_x, e_y, 1, buttons_state, k);
			left_button_press_actions.execute (Current, cd)
		end

	on_left_button_up (keys, a_x, a_y: INTEGER)
			-- Wm_lbuttonup message
			-- See class WEL_IMPK_CONSTANTS for `keys' value
		local
			cd: BUTREL_DATA;
			k: KEYBOARD_WINDOWS
			w: WIDGET_IMP
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			w := left_button_down_widget
			create wp.make (a_x, a_y)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			left_button_down_implementation.set_item (false);
			left_button_down_widget_implementation.replace (Void);
			create k.make_from_mouse_state (keys)
			create cd.make (owner, a_x, a_y, e_x, e_y, 1, buttons_state, k);
			left_button_release_actions.execute (Current, cd)
			if has_capture then
				wel_release_capture
				if in_button_area (a_x, a_y) then
					activate_actions.execute (Current, Void)
				end
				is_being_pressed := False
				if exists then
					invalidate
				end
			else
				is_being_pressed := False
			end
		end

	on_draw (a_draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Respond to a draw_item message.
		local
			dc: WEL_DC
		do
			dc := a_draw_item_struct.dc
			if is_pressed or is_being_pressed then
				draw_all_selected (dc)
			else
				if flag_set (a_draw_item_struct.item_state, Ods_selected) then
					draw_all_selected (dc)
				else
					draw_all_unselected (dc)
				end
			end	
		end

	draw_selected (a_dc: WEL_DC)
		local
			bitmap: WEL_BITMAP
			pixmap_w: PIXMAP_IMP
			dib: WEL_DIB
			pixmap_x, pixmap_y : INTEGER
		do
			if pixmap /= Void then
				pixmap_w ?= pixmap.implementation
				dib := pixmap_w.dib
				check
					dib_exists: dib /= Void
				end
				create bitmap.make_by_dib (a_dc, dib, dib_rgb_colors)
				if alignment_type = center_alignment_type then
					pixmap_x := (3 + ((internal_width - bitmap.width) // 2))
					pixmap_y := (3 + ((internal_height - bitmap.height) // 2))
					a_dc.draw_bitmap (bitmap, pixmap_x, pixmap_y, internal_width, internal_height)
				else
					a_dc.draw_bitmap (bitmap, 3, 3, internal_width, internal_height)
				end
				bitmap.delete
			end
		end

	draw_unselected (a_dc: WEL_DC)
		local
			bitmap: WEL_BITMAP
			pixmap_w: PIXMAP_IMP
			dib: WEL_DIB
			pixmap_x, pixmap_y : INTEGER
		do
			if pixmap /= Void then
				pixmap_w ?= pixmap.implementation
				dib := pixmap_w.dib
				check
					dib_exists: dib /= Void
				end
				create bitmap.make_by_dib (a_dc, dib, dib_rgb_colors)
				if alignment_type = center_alignment_type then
					pixmap_x := (2 + ((internal_width - bitmap.width) // 2))
					pixmap_y := (2 + ((internal_height - bitmap.height) // 2))
					a_dc.draw_bitmap (bitmap, pixmap_x, pixmap_y, internal_width, internal_height)
				else
					a_dc.draw_bitmap (bitmap, 2, 2, internal_width, internal_height)
				end
				bitmap.delete
			end
		end

	internal_width: INTEGER
		require
			exists: exists
		do
			Result := (width - Total_offset).max (0)
		ensure
			positive_result: Result >= 0
		end

	internal_height: INTEGER
		require
			exists: exists
		do
			Result := (height - Total_offset).max (0)
		ensure
			positive_result: Result >= 0
		end

	is_being_pressed: BOOLEAN
		-- Is this button currently being pressed?

	Total_offset: INTEGER 
		do
			Result := 5
		end

	in_button_area (a_x, a_y: INTEGER): BOOLEAN
			-- Is position marked by `a_x' and `a_y' in the
			-- area of the button?
		do
			if 
				a_x <= width and then
				a_y <= height and then
				a_x >= 0 and then
				a_y >= 0
			then
				Result := True
			end
		end

	on_bn_clicked
			-- Do nothing
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class PICT_COLOR_B_IMP

