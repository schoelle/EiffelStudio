note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	CHILD_WINDOW

inherit
	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make
		redefine
			on_paint,
			class_icon,
			on_destroy
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: PATH)
		local
			file: RAW_FILE
			dc: WEL_CLIENT_DC
			dib: WEL_DIB
			l_bitmap: like bitmap
		do
			mdi_child_window_make (a_parent, a_name.name)
			create file.make_with_path (a_name)
			file.open_read
			create dib.make_by_file (file)
			create dc.make (Current)
			dc.get
			create l_bitmap.make_by_dib (dc, dib, Dib_rgb_colors)
			bitmap := l_bitmap
			dc.release
			create scroller.make (Current, l_bitmap.width, l_bitmap.height, 1, 20)
		end

feature -- Access

	bitmap: detachable WEL_BITMAP
			-- Bitmap selected by the user

feature -- Basic operations

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Paint the bitmap
		local
			l_bitmap: like bitmap
		do
			l_bitmap := bitmap
				-- Per invariant
			check l_bitmap_attached: l_bitmap /= Void end
			paint_dc.draw_bitmap (l_bitmap, 0, 0, l_bitmap.width, l_bitmap.height)
		end

	on_destroy
			-- Notify `parent' that `Current' is being destroyed.
		do
			if attached {MAIN_WINDOW} parent as main_window then
				main_window.remove_child_reference (Current)
			else
				check False end
			end
		end


feature {NONE} -- Implementation

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_child_window)
		end

invariant
	bitmap_attached: bitmap /= Void

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


end -- class CHILD_WINDOW

