indexing

	description: 
		"EiffelVision text area, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_IMP
	
inherit
	EV_TEXT_I
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			internal_set_caret_position,
			insert_text,
			visual_widget,
			set_background_color
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			visual_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL))
			feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (c_object, C.GTK_POLICY_AUTOMATIC_ENUM, C.GTK_POLICY_AUTOMATIC_ENUM)
			entry_widget := gtk_text_new (NULL, NULL)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, entry_widget)
			gtk_text_set_editable (entry_widget, True)
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := feature {EV_GTK_EXTERNALS}.gtk_editable_get_chars (entry_widget, 0, -1)
			create Result.make_from_c (p)
			feature {EV_GTK_EXTERNALS}.g_free (p)
		end

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		local
			line_begin_pos, line_end_pos: INTEGER
			counter : INTEGER
			p: POINTER
		do
			from
				counter := 1
				line_begin_pos := 1
				line_end_pos := 1
			until
				counter = i
			loop
				line_begin_pos := text.index_of ('%N', line_begin_pos)
				counter := counter + 1
				line_begin_pos := line_begin_pos + 1
			end

			-- We do not substract 1 to `line_end_pos' because of 
			-- GTK function `gtk_editable_get_chars'.
			line_end_pos := text.index_of ('%N', line_begin_pos)

			if (line_end_pos = 0) and then (counter = line_count) then
				-- the required line is the last line and there
				-- is no return at the end of it.
				line_end_pos := text.count + 1
				-- The `+ 1' is due to GTK function `gtk_editable_get_chars'. 
			end

			p := feature {EV_GTK_EXTERNALS}.gtk_editable_get_chars (entry_widget, line_begin_pos - 1, line_end_pos - 1)
			create Result.make_from_c (p)
			feature {EV_GTK_EXTERNALS}.g_free (p)
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines present in widget.
		local
			temp_text: STRING
		do
				Result := feature {EV_GTK_EXTERNALS}.gtk_adjustment_struct_upper (vertical_adjustment_struct).rounded // line_height
				temp_text := text
				if temp_text /= Void then
					Result := Result.max (temp_text.occurrences ('%N') + 1)
					-- This is in case scroll bar has not been set
				end
		end

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		local
			p: POINTER
			temp_string: STRING
		do
			if is_displayed then
				Result := (gtk_text_struct_cursor_pos_y (entry_widget) + gtk_text_struct_first_onscreen_ver_pixel (entry_widget)) // line_height
			else
				p := feature {EV_GTK_EXTERNALS}.gtk_editable_get_chars (entry_widget, 0, gtk_text_get_point (entry_widget))
				create temp_string.make_from_c (p)
				feature {EV_GTK_EXTERNALS}.g_free (p)
				Result := temp_string.occurrences ('%N') + 1
			end
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := gtk_text_get_point (entry_widget) + 1
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		local
			pos : INTEGER
			count: INTEGER
			start: INTEGER
		do
			if (i = 1) then
				Result := 1
			else
				from
					count := 1
					pos := 1
					start := 1
				until
					count = i
				loop
					-- Look for the ith 'Return' in the string.
					-- Return is symbolized by '%N'
					pos := text.index_of ('%N', start)
					count := count + 1
					start := pos + 1
				end
				Result := pos + 1
			end
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		local
			pos : INTEGER
			count: INTEGER
			start: INTEGER
		do
			if (i = line_count) then
				Result := text.count
			else
				from
					count := 1
					pos := 1
					start := 1
				until
					count = i + 1
				loop
					-- Look for the (i + 1)th `Return' in the string.
					-- Return is symbolized by '%N'
					pos := text.index_of ('%N', start)
					count := count + 1
					start := pos + 1
				end
				Result := pos
			end
		end

feature -- Status setting
		
	set_background_color (a_color: EV_COLOR) is
			-- Set background color of present
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (a_color)
			-- We need to set the font again due to bug in GtkText widget.
			set_font (font)
		end

	internal_set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			gtk_text_set_point (entry_widget, pos - 1)
			Precursor {EV_TEXT_COMPONENT_IMP} (pos)
		end
	
	insert_text (txt: STRING) is
		local
			a_gs: GEL_STRING
		do
			create a_gs.make (txt)
			gtk_text_insert (entry_widget, NULL, NULL, NULL, a_gs.item, -1)
		end
	
	set_text (txt: STRING) is
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_delete_text (entry_widget, 0, -1)
			insert_text (txt)
		end
	
	append_text (txt: STRING) is
			-- Append `txt' to `text'.
		local
			temp_caret_pos: INTEGER
		do
			temp_caret_pos := caret_position
			gtk_text_set_point (entry_widget, text_length)
			insert_text (txt)
			set_caret_position (temp_caret_pos)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend 'txt' to `text'.
		local
			temp_caret_pos: INTEGER
		do
			temp_caret_pos := caret_position
			gtk_text_set_point (entry_widget, 0)
			insert_text (txt)
			set_caret_position (temp_caret_pos)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_delete_text (entry_widget, start + 1, finish + 1)
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
			gtk_text_freeze (entry_widget)
		end

	thaw is
			-- Thaw a frozen widget.
		do
			gtk_text_thaw (entry_widget)
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		do
			insert_text ("%N")
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		do
			Result := text.substring_index (str, start)
		end

	scroll_to_line (i: INTEGER) is
		do
			freeze
			feature {EV_GTK_EXTERNALS}.gtk_adjustment_set_value (vertical_adjustment_struct, (i - 1) * line_height)
			thaw
		end

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		local
			temp_text: STRING
		do
			temp_text := text
			Result := not ((temp_text @ temp_text.count) = '%N')
		end
		
feature {NONE} -- Implementation

	vertical_adjustment_struct: POINTER is
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_range_struct_adjustment (feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_struct_vscrollbar (c_object))
		end

	line_height: INTEGER is
			-- Height of the text lines in the widget.
		do
			if private_font /= Void then
				Result := private_font.ascent + private_font.descent
			else
				Result := App_implementation.Default_font_ascent + App_implementation.Default_font_descent
			end
		end

	entry_widget: POINTER
		-- Pointer to the gtk text editable.
		
	visual_widget: POINTER is
			-- Pointer to widget shown on screen.
		do
			Result := entry_widget
		end
		
feature {NONE} -- Externals

	gtk_text_new (a_hadj: POINTER; a_vadj: POINTER): POINTER is
			-- GtkWidget* gtk_text_new             (GtkAdjustment *hadj,
			--                                   GtkAdjustment *vadj);
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <gtk/gtk.h>"
		end

	gtk_text_set_editable (a_text: POINTER; a_editable: BOOLEAN) is
			-- void       gtk_text_set_editable    (GtkText       *text,
			-- 				     gboolean       editable);
		external
			"C (GtkText*, gboolean) | <gtk/gtk.h>"
		end
		
	gtk_text_struct_cursor_pos_y (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkText): EIF_INTEGER"
		alias
			"cursor_pos_y"
		end
		
	gtk_text_struct_first_onscreen_ver_pixel (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkText): EIF_INTEGER"
		alias
			"first_onscreen_ver_pixel"
		end
		
	gtk_text_get_point (a_text: POINTER): INTEGER is
			-- guint      gtk_text_get_point       (GtkText       *text);
		external
			"C (GtkText*): guint | <gtk/gtk.h>"
		end
		
	gtk_text_insert (a_text: POINTER; a_font: POINTER; a_fore: POINTER; a_back: POINTER; a_chars: POINTER; a_length: INTEGER) is
			-- void       gtk_text_insert          (GtkText       *text,
			-- 				     GdkFont       *font,
			-- 				     GdkColor      *fore,
			-- 				     GdkColor      *back,
			-- 				     const char    *chars,
			-- 				     gint           length);
		external
			"C (GtkText*, GdkFont*, GdkColor*, GdkColor*, char*, gint) | <gtk/gtk.h>"
		end
		
	gtk_text_set_point (a_text: POINTER; a_index: INTEGER) is
			-- void       gtk_text_set_point       (GtkText       *text,
			-- 				     guint          index);
		external
			"C (GtkText*, guint) | <gtk/gtk.h>"
		end
		
	gtk_text_freeze (a_text: POINTER) is
			-- void       gtk_text_freeze          (GtkText       *text);
		external
			"C (GtkText*) | <gtk/gtk.h>"
		end
		
	gtk_text_thaw (a_text: POINTER) is
			-- void       gtk_text_thaw            (GtkText       *text);
		external
			"C (GtkText*) | <gtk/gtk.h>"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT

end -- class EV_TEXT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

