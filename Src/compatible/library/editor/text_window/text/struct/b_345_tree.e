note
	description: "3-4-5 Balanced Tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	B_345_TREE

inherit
	ANY

create
	make

feature -- Initialization

	make
		do
			create root_node.make
		end

feature -- Access

	count: INTEGER
		do
			Result := root_node.keys_plus_one - 1
		end

	first_data: TREE_ITEM

	last_data: like first_data

	item (i: INTEGER): like first_data
		require
			i_is_valid: i >= 1 and i <= count
		do
			Result := root_node.item (i).data
		end

feature -- Element Change

	set_first_data (tl: like first_data)
		do
			first_data := tl
		end

	set_last_data (tl: like first_data)
		do
			last_data := tl
		end

	prepend_data (tl: like first_data)
			-- add tl at the beginning of the tree.
		require
			tl_not_linked: tl.next = Void and then tl.previous = Void
		local
			ti: TREE_KEY [like first_data]
		do
			tl.set_tree (Current)
			create ti.make (tl)
			tl.set_key (ti)
			if first_data = Void then
				set_last_data (tl)
				root_node.insert_first (ti)
			else
				tl.set_next (first_data)
				first_data.set_previous (tl)
				first_data.key.add_left (ti)
			end
			set_first_data (tl)
		ensure
			tl_linked: tl /= last_data implies
				(tl.next /= Void and then tl.next.previous = tl)
			tl_has_key: tl.key /= Void
			tl_has_tree: tl.tree /= Void
		end

	append_data (tl: like first_data)
			-- add tl at the end of the tree.
		require
			tl_not_linked: tl.next = Void and then tl.previous = Void
		local
			ti: TREE_KEY [like first_data]
		do
			tl.set_tree (Current)
			create ti.make (tl)
			tl.set_key (ti)
			if last_data = Void then
				set_first_data (tl)
				root_node.insert_last (ti)
			else
				tl.set_previous (last_data)
				last_data.set_next (tl)
				last_data.key.add_right (ti)
			end
			set_last_data (tl)
		ensure
			tl_linked: tl /= first_data implies
				(tl.previous /= Void and then tl.previous.next = tl)
			tl_has_key: tl.key /= Void
			tl_has_tree: tl.tree /= Void
		end

feature -- Removal

		wipe_out
				-- Erase data.
			local
				l_default: like first_data
			do
				set_first_data (l_default)
				set_last_data (l_default)
				create root_node.make
			end


feature {NONE} -- Implementation

	root_node: TREE_NODE [like first_data];

invariant
	first_data_valid: first_data /= Void implies first_data.is_valid
	last_data_valid: last_data /= Void implies last_data.is_valid

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




end -- B_345_TREE
