note

	description: "Area for free-form placement on any of its children"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	BULLETIN

inherit

	MANAGER
		redefine
			implementation
		end

create

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {BULLETIN_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Status report

	valid_stackables (a_stackable_array: ARRAY [STACKABLE]): BOOLEAN
			-- check that the array of stackables meets the critea
			-- require for widgets to be restacked
		require
			exists: not destroyed;
			valid_array: a_stackable_array /= Void and then
					not a_stackable_array.is_empty;
		local
			index1: INTEGER;
		do
			Result := True;
			from index1 := a_stackable_array.lower
			until  not Result or else index1 > a_stackable_array.upper
			loop
				If a_stackable_array.item (index1) = Void  then
					Result := False;
				elseif not a_stackable_array.item (index1).is_stackable or else
				  not a_stackable_array.item (index1).realized or else
				  a_stackable_array.item (index1).parent /= a_stackable_array.item(a_stackable_array.lower).parent then
					Result := False;
				end;
				index1 := index1 + 1;
			end;
		end;

feature -- Status setting

	allow_recompute_size
			-- Allow Current bulletin to recompute its size
			-- according to its children.
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size
			-- Forbid Current bulletin to recompute its size
			-- according to its children.
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size
		end;

	set_default_position (flag: BOOLEAN)
			-- Set default position of Current to `flag'.
		require
			exists: not destroyed
		do
			implementation.set_default_position (flag);
		end;

	circulate_up
			-- Circulate the children of this widget up
		require
			exists: not destroyed
		do
			implementation.circulate_up;
		end;

	circulate_down
			-- Circulate the children of this widget down
		require
			exists: not destroyed
		do
			implementation.circulate_down;
		end;

	restack_children (a_stackable_array: ARRAY [STACKABLE])
			-- the stackable's in the array have to have the
			-- same parent.
		require
			exists: not destroyed;
			valid_restackable: valid_stackables (a_stackable_array);
		do
			implementation.restack_children (a_stackable_array);
		end;

feature {NONE} -- Implementation

	set_default
			-- Set default values to current bulletin.
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: BULLETIN_I;
			-- Implementation of bulletin

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




end -- class BULLETIN

