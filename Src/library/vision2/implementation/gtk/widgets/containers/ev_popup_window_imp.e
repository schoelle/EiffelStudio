indexing
	description: "EiffelVision popup window, GTK+ implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_POPUP_WINDOW_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update,
			show_disconnected_from_window_manager
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			interface,
			make,
			initialize,
			default_wm_decorations,
			client_area,
			set_focus,
			show,
			internal_enable_border,
			internal_disable_border,
			on_mouse_button_event
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.gtk_window_toplevel_enum))
		end

	initialize is
			-- Initialize `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_pager_hint (c_object, True)
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
			client_area := {EV_GTK_EXTERNALS}.gtk_event_box_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (client_area)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, client_area)
			Precursor {EV_WINDOW_IMP}

				-- This completely disconnects the window from the window manager.
--			{EV_GTK_EXTERNALS}.gdk_window_set_override_redirect ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), True)
			disable_border
			user_can_resize := False
			set_background_color ((create {EV_STOCK_COLORS}).Dark_grey)
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	on_mouse_button_event (a_type: INTEGER_32; a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32) is
		do
			Precursor (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
--			if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum then
--				if
--					a_screen_x >= x_position and then
--					a_screen_x <= (x_position + width) and then
--					a_screen_y >= y_position and then
--					a_screen_y <= (y_position + height)
--				then
--					grab_keyboard_and_mouse
--					print ("Call focus in actions%N")
--				else
--					release_keyboard_and_mouse
--					print ("Call focus out actions%N")
--				end
--			end
		end

	border_width: INTEGER is 2
		-- Border width of `Current'.

	internal_enable_border is
			-- Ensure a border is displayed around Current.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, border_width)
		end

	internal_disable_border is
			-- Ensure no border is displayed around Current.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, 0)
		end

	set_focus is
			--
		do
			Precursor
--			grab_keyboard_and_mouse
		end

	show is
			--
		do
--			grab_keyboard_and_mouse
			Precursor
		end

	show_disconnected_from_window_manager is
			--
		do
			show
--			grab_keyboard_and_mouse
		end

	default_wm_decorations: INTEGER is
			-- Default Window Manager decorations of `Current'.
		do
			Result := 0
		end

	client_area: POINTER

feature {NONE} -- Implementation

feature {EV_ANY_I} -- Implementation

	interface: EV_POPUP_WINDOW;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_POPUP_WINDOW_IMP

