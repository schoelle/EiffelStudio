indexing

	description:
		"Structures with a finite item count";

	status: "See notice at end of class";
	names: finite, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class FINITE [G] inherit

	BOX [G]

feature -- Measurement

	count: INTEGER is
			-- Number of items
		deferred
		end;

feature -- Status report

	empty: BOOLEAN is
			-- Is structure empty?
		do
			Result := (count = 0)
		end;

invariant

	empty_definition: empty = (count = 0);
	non_negative_count: count >= 0

end -- class FINITE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
