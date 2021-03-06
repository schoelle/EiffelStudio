note
	description:
		"Eiffel Vision dynamic list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST_I [reference G -> EV_CONTAINABLE]

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	item: G
			-- Current item
		require
			readable: index > 0 and then index <= count
		do
			Result := i_th (index)
		ensure
			not_void: Result /= Void
		end

	index: INTEGER
			-- Index of current position

	cursor: EV_DYNAMIC_LIST_CURSOR [G]
			-- Current cursor position.
		local
			an_item: like item
		do
			if index > 0 and then index <= count then
				an_item := item
			end
			create Result.make (an_item, index <= 0, index > count)
		ensure
			not_void: Result /= Void
		end

	i_th (i: INTEGER): G
			-- Item at `i'-th position.
		require
			i_within_bounds: i > 0 and then i <= count
		deferred
		ensure
			not_void: Result /= Void
		end

	off: BOOLEAN
			-- Is there no current item?
		do
			Result := (index = 0) or (index = count + 1)
		end

	index_of (v: like item; i: INTEGER): INTEGER
			-- Index of i_th item `v', if present.
			-- As dynamic list descendants are all sets,
			-- Result will be zero for all values of `i'
			-- that are not equal to one
		require
			positive_occurrences: i > 0
		local
			an_index: INTEGER
		do
			if i = 1 then
				from
					an_index := 1
				until
					Result > 0 or else an_index > count
				loop
					if i_th (an_index) = v then
						Result := an_index
					end
					an_index := an_index + 1
				end
			end
		end

	retrieve_item_by_data (data: ANY; should_compare_objects: BOOLEAN): G
			-- `Result' is first item in `Current' with data
			-- matching `some_data'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		local
			c: CURSOR
		do
			c := cursor
			from
				interface.start
			until
				interface.after or Result /= Void
			loop
				if
					(should_compare_objects and then ((data = Void and then item.data = Void) or
					data /= void and item.data /= Void and then data.same_type (item.data) and then data.is_equal (item.data)))
					or (not should_compare_objects and data = item.data)
				then
					Result := item
				end
				interface.forth
			end
			go_to (c)
		end

	retrieve_items_by_data (data: ANY; should_compare_objects: BOOLEAN): ARRAYED_LIST [G]
			-- `Result' is all items in `Current' with data
			-- matching `some_data'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		local
			c: CURSOR
		do
			create Result.make (0)
			c := cursor
			from
				interface.start
			until
				interface.after
			loop
				if (should_compare_objects and then ((data = Void and then item.data = Void) or
					data /= void and item.data /= Void and then data.same_type (item.data) and then data.is_equal (item.data)))
					or (not should_compare_objects and data = item.data) then
					Result.extend (item)
				end
				interface.forth
			end
			go_to (c)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.
		deferred
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_DYNAMIC_LIST_CURSOR and
			-- if it points to an item, `Current' must have it.
		local
			dlc: EV_DYNAMIC_LIST_CURSOR [G]
		do
			dlc ?= p
			Result := dlc /= Void and then
				(dlc.item = Void or else has (dlc.item))
		end

	has (v: like item): BOOLEAN
			-- Does structure contain `v'?
		require
			v_not_void: v /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				Result or else i > count
			loop
				Result := i_th (i) = v
				i := i + 1
			end
		end

feature -- Cursor movement

	start
			-- Move cursor to first position.
		do
			index := 1
		ensure
			index_on_first: index = 1
		end

	back
			-- Move to previous item.
		require
			not_before: index > 0
		do
			index := index - 1
		end

	forth
			-- Move cursor to next position.
		require
			not_after: index <= count
		do
			index := index + 1
		end

	go_i_th (i: INTEGER)
			-- Move cursor to `i'-th position.
		do
			index := i
			if index < 0 then
				index := 0
			elseif index > count + 1 then
				index := count + 1
			end
		end

	go_to (p: CURSOR)
			-- Move cursor to position `p'.
		local
			dlc: EV_DYNAMIC_LIST_CURSOR [G]
		do
			dlc ?= p
			check
				dlc_not_void: dlc /= Void
			end
			if dlc.after then
				index := count + 1
			elseif dlc.before then
				index := 0
			else
				index := index_of (dlc.item, 1)
			end
		end

	move (i: INTEGER)
			-- Move cursor `i' positions.
		do
			index := index + i
			if index < 0 then
				index := 0
			elseif index > count + 1 then
				index := count + 1
			end
		end

feature -- Element change

	append (s: SEQUENCE [G])
			-- Append a copy of `s'. Do not move cursor.
		require
			sequence_not_void: s /= Void
		do
			from
				s.start
			until
				s.off
			loop
				extend (s.item)
				s.forth
			end
		ensure
			count_increased: old count + s.count = count
		end

	extend (v: like item)
			-- Add `v' to end. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, count + 1)
			if index = count then
				index := index + 1
			end
		ensure
			has_v: has (v)
		end

	replace (v: like item)
			-- Replace current item by `v'.
		require
			writable: index > 0 and then index <= count
			v_not_void: v /= Void
		do
			remove_i_th (index)
			insert_i_th (v, index)
		ensure
			has_v: has (v)
		end

	put_front (v: like item)
			-- Add `v' at beginning. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, 1)
			if index > 0 then
				index := index + 1
			end
		ensure
			has_v: has (v)
		end

	put_right (v: like item)
			-- Add `v' to the right of cursor position. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, index + 1)
		ensure
			has_v: has (v)
		end

	put_left (v: like item)
			-- Add `v' to the left of cursor position. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, index)
			index := index + 1
		ensure
			has_v: has (v)
		end

	put_i_th (v: like item; i: INTEGER)
			-- Replace item at `i'-th position by `v'.
		require
			valid_index: i > 0 and i <= count
			v_not_void: v /= Void
		do
			insert_i_th (v, i)
			remove_i_th (i + 1)
		ensure
			has_v: has (v)
		end

	merge_left (other: like interface)
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		local
			v: like item
		do
			from
				other.start
			until
				other.is_empty
			loop
				v := other.item
				other.remove
				insert_i_th (v, index)
				index := index + 1
			end
		end

	merge_right (other: like interface)
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		local
			v: like item
		do
			from
			until
				other.is_empty
			loop
				other.finish
				v := other.item
				other.remove
				insert_i_th (v, index + 1)
			end
		end

feature -- Removal

	prune (v: like item)
			-- Remove `v' if present. Do not move cursor, except if
			-- cursor was on `v', move to right neighbor.
		local
			item_index: INTEGER
		do
			item_index := index_of (v, 1)
			if item_index > 0 then
					-- Update index should the item position being removed
					-- come before the current index position.
				if item_index <= index then
					index := index - 1
				end
				remove_i_th (item_index)
			end
		ensure
			--| It is not possible to call old item as if off, it will cause
			--| imp to_int to fail and because all old expressions are evaluated
			--| on entry to a routine, we cannot check that we were not off
			--| before evaluating old item. Julian.
			cursor_not_moved: not old has (v) implies
				old interface.index = interface.index
			cursor_not_moved: old has (v) and then old interface.index <
				old index_of (v, 1) implies index = old index
			cursor_not_moved: old has (v) and then old interface.index >=
				old index_of (v, 1) implies index = old index - 1
			not_has_v: not has (v)
		end

	remove
			-- Remove current item. Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		require
			writable: not off
		do
			remove_i_th (index)
			if index > count + 1 then
				index := count + 1
			end
		ensure
			not_has_v: not has (old item)
		end

	remove_left
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require
			left_exists: index > 1
			not_before: not (index = 0)
		do
			index := index - 1
			remove_i_th (index)
		ensure then
			left_neighbor_removed: not has (old i_th (index - 1))
		end

	remove_right
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			right_exists: index < count
		do
			remove_i_th (index + 1)
		ensure then
			right_neighbor_removed: not has (old i_th (index + 1))
		end

	wipe_out
			-- Remove all items.
		local
			l_index: INTEGER
			l_interface: like interface
		do
			from
				l_interface := interface
				l_index := l_interface.count
			until
				l_index = 0
			loop
				l_interface.go_i_th (l_index)
				l_interface.remove
				l_index := l_index - 1
			end
			l_interface.go_i_th (l_index)
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		require
			i_within_bounds: i > 0 and i <= count + 1
		deferred
		ensure
			count_increased: count = old count + 1
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		require
			i_within_bounds: i > 0 and i <= count
		deferred
		ensure
			count_decreased: count = old count - 1
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DYNAMIC_LIST [G]

invariant
	index_within_bounds: is_usable implies (index >= 0 and then
		index <= count + 1)

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




end -- class EV_DYNAMIC_LIST_I

