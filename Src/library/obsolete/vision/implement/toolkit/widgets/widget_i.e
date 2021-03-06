note

	description: "General widget implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	WIDGET_I 

feature -- Access

	get_multi_click_time: INTEGER
			-- Get time granted for clicking
		deferred
		end;

	background_color: COLOR
			-- Background color of widget
		deferred
		ensure
			valid_result: Result /= Void
		end;

	background_pixmap: PIXMAP
			-- Background pixmap of widget
		deferred
		end;

	cursor: SCREEN_CURSOR
			-- Cursor of current widget
		deferred
		end;

	height: INTEGER
			-- Height of widget
		deferred
		ensure
			height_large_enough: Result >= 0
		end;

	real_x: INTEGER
			-- Horizontal position relative to root window
		deferred
		end;

	real_y: INTEGER
			-- Vertical position relative to root window
		deferred
		end;

	screen: SCREEN_I
			-- Screen of widget
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	screen_object: POINTER
			-- Screen object implementation of current widget
		deferred
		end;

	width: INTEGER
			-- Width of widget
		deferred
		ensure
			width_large_enough: Result >= 0
		end;

	x: INTEGER
			-- Horizontal position relative to parent
		deferred
		end;

	y: INTEGER
			-- Vertical position relative to parent
		deferred
		end

	widget_index: INTEGER
			-- Index entry of widget in widget_manager
		deferred
		end;

feature -- Status report

	realized: BOOLEAN
			-- Is screen window realized?
		deferred
		end;

	insensitive: BOOLEAN
			-- Is current widget sensitive?
		deferred
		end;

	managed: BOOLEAN
			-- Is there geometry managment on screen widget implementation
			-- performed by window manager of parent widget?
		deferred
		end;

	shown: BOOLEAN
			-- Is current widget visible?
		require
			widget_realized: realized
		deferred
		end;

	clean_up
			-- Clean up data information for destroyed widget.
		deferred
		end;

feature -- Status setting

	lower
		-- lower current to the bottom of its
		-- peers stacking order
		deferred
		end;

	hide
			-- Make widget invisible on the screen.
		require
			widget_realized: realized
		deferred
		ensure
			not shown
		end;

	destroy (wid_list: LINKED_LIST [WIDGET])
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children
			-- contained in `wid_list;.
		require
			non_void_list: wid_list /= Void;
			list_not_empty: not wid_list.is_empty
		deferred
		end;

	grab (a_cursor: SCREEN_CURSOR)
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		require
			widget_realized: realized
		deferred
		end;

	propagate_event
			-- Propagate event to direct ancestor if no action
			-- is specified for event. 
		require
			widget_realized: realized
		deferred
		end;

	raise
			-- Raise current to top of peer stacking order
		deferred
		end;

	realize
			-- Create screen window implementation and all
			-- screen window implementations of its children if `flag'.
		deferred
		ensure
			realized
		end;

	set_insensitive (flag: BOOLEAN)
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		deferred
		ensure
			flag = insensitive
		end;

	set_managed (flag: BOOLEAN)
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		deferred
		ensure
			managed = flag
		end;

	set_no_event_propagation
			-- Don't propagate event to direct ancestor.
		require
			widget_realized: realized
		deferred
		end;

	set_size (new_width:INTEGER; new_height: INTEGER)
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require
			width_large_enough: new_width >= 0;
			height_large_enough: new_height >= 0
		deferred
		end;

	set_widget_default
		deferred
		end

	set_width (new_width :INTEGER)
			-- Set width to `new_width'.
		require
			width_large_enough: new_width >= 0;
		deferred
		end;

	set_x (new_x: INTEGER)
			-- Put at horizontal position `new_x' relative
			-- to parent.
		deferred
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER)
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		deferred
		end;

	set_y (new_y: INTEGER)
			-- Put at vertical position `new_y' relative
			-- to parent.
		deferred
		end;

	show
			-- Make widget visible on the screen.
		require
			widget_realized: realized
		deferred
		end;

	ungrab
			-- Release the mouse and the keyboard from an earlier grab.
		require
			widget_realized: realized
		deferred
		end;

	unrealize
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		deferred
		ensure
			not realized
		end;

feature -- Element change

	 set_widget_index (index: INTEGER)
			-- Set widget_index to `index'.
		require
			positive_value: index > 0
		deferred
		end;

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY)
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require
			not_a_command_void: a_command /= Void;
			a_translation_exists: a_translation /= Void
		deferred
		end;

	set_background_color (new_color: COLOR)
			-- Set background color to `new_color'.
		require
			argument_not_void: new_color /= Void
		deferred
		ensure
			background_color_set: background_color = new_color;
		end;

	set_background_pixmap (a_pixmap: PIXMAP)
			-- Set background pixmap to `a_pixmap'.
		require
			argument_not_void: a_pixmap /= Void
		deferred
		ensure
			background_pixmap_set: background_pixmap = a_pixmap;
		end;

	set_cursor (a_cursor: SCREEN_CURSOR)
			-- Set `cursor' of current widget to `a_cursor'.
		require
			cursor_not_void: a_cursor /= Void
			widget_realized: realized
		deferred
		end;

	set_height (new_height: INTEGER)
			-- Set height to `new_height'.
		require
			height_large_enough: new_height >= 0
		deferred
		end;

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	set_multi_click_time (time: INTEGER)
			-- Set time granted for clicking
		deferred
		end;

	add_destroy_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_enter_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- pointer enter the window.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_key_press_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when a key
			-- is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when a key
			-- is released.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_leave_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- pointer leave the window.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_pointer_motion_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_action (a_translation: STRING)
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require
			a_translation_exists: a_translation /= Void
		deferred
		end;

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_destroy_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_enter_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when the
			-- pointer enter the window.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_key_press_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when a key
			-- is pressed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when a key
			-- is released.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_leave_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when the
			-- pointer leave the window.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

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




end -- class WIDGET_I

