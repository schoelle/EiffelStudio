note

	description: 
		"EiffelVision implementation of a motif primitive widget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	PRIMITIVE_IMP

inherit

	WIDGET_IMP
		redefine
			set_background_color_from_imp
		end;

	MEL_PRIMITIVE
		rename
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		end

feature -- Access

	is_stackable: BOOLEAN 
			-- Is the Current widget stackable?
		do
			Result := True
		end;

feature -- Status Report

	foreground_color: COLOR
			-- Color used for the foreground_color
		local
			fg_color_x: COLOR_IMP
		do
			if private_foreground_color = Void then
				create private_foreground_color.make;
				fg_color_x ?= private_foreground_color.implementation;
				fg_color_x.set_default_pixel (mel_foreground_color, 
						mel_screen.default_colormap);
				fg_color_x.increment_users
			end;
			Result := private_foreground_color;
		end;

feature -- Status Setting

	set_foreground_color (a_color: COLOR)
			-- Set `foreground_color' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		local
			color_implementation: COLOR_IMP;
		do
			if private_foreground_color /= Void then
				color_implementation ?= private_foreground_color.implementation;
				color_implementation.decrement_users;
			end;
			private_foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.increment_users;
			color_implementation.allocate_pixel;
			mel_set_foreground_color (color_implementation)
		ensure
			set: foreground_color = a_color
		end;

feature {COLOR_IMP} -- Implementation

	private_foreground_color: COLOR;
			-- Foreground_color colour

	update_foreground_color
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_IMP
		do
			color_implementation ?= private_foreground_color.implementation;
			color_implementation.allocate_pixel;
			mel_set_foreground_color (color_implementation);
		end

feature {NONE} -- Implementation

	set_background_color_from_imp (color_imp: COLOR_IMP)
			-- Set the background color from implementation `color_imp'.
		do
			mel_set_background_color (color_imp);
			xm_change_color (screen_object, color_imp.identifier);
			if private_foreground_color /= Void then
				update_foreground_color
			end
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




end -- class PRIMITIVE_IMP

