indexing
	description: "Stream of data stored in non Eiffel memory"
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_STREAM

inherit
	MEMORY
		redefine
			dispose, copy, is_equal
		end

create
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make (a_size: INTEGER) is
			-- Initialize current with `a_size' bytes.
		require
			valid_size: a_size >= 0
		do
			create area.make (a_size)
			is_resizable := True
		ensure
			non_void_area: area /= Void
			capacity_set: capacity = a_size
			is_resizable_set: is_resizable
		end

	make_from_pointer (an_area: POINTER; a_size: INTEGER) is
			-- Initialize Current with `an_area' and `a_size'.
			-- Current will not be resizable as we do not know
			-- who created `an_area'.
		require
			an_area_not_null: an_area /= default_pointer
			valid_size: a_size >= 0
		do
			create area.make (a_size)
			is_resizable := False
		ensure
			non_void_area: area /= Void
			capacity_set: capacity = a_size
			is_resizable_set: not is_resizable
		end

feature -- Access

	capacity: INTEGER is
			-- Number of bytes in Current.
		do
			Result := area.count
		end

	area: MANAGED_POINTER
			-- Memory area that holds data.

	item, infix "@" (i: INTEGER): INTEGER_8 is
			-- Entry at index `i'.
		require
			valid_index: valid_index (i)			
		do
			($Result).memory_copy (area.item + i, 1)
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < capacity)
		end

	is_resizable: BOOLEAN
			-- Can Current be resized?

feature -- Setting

	set_capacity (n: INTEGER) is
		require
			valid_index: valid_index (n - 1)
		do
			area.resize (n)
		ensure
			capacity_set: capacity = n
		end

feature -- Element change

	put (v: INTEGER_8; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
		require
			valid_index: valid_index (i)
		do
			area.put_integer_8 (v, i)
		ensure
			inserted: item (i) = v
		end

	force (v: INTEGER_8; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
			-- If `i' is out of bound, reallocate Current.
		do
			if not valid_index (i) then
				area.resize (i + 1)
			end
			area.put_integer_8 (v, i)
		ensure
			inserted: item (i) = v
		end

	append (other: like Current) is
			-- Append `other' at the end of Current.
		require
			other_not_void: other /= Void
			resizable: is_resizable
		do
			area.resize (capacity + other.capacity)
			area.append (other.area)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := capacity = other.capacity and then area.item.memory_compare (other.area.item, capacity)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Copy other in Current
		do
			area.item.memory_free
			make (other.capacity)
			area.item.memory_copy (other.area.item, other.capacity)
		end

feature {NONE} -- Disposal

	dispose is
			-- Release `area'.
		do
			area.item.memory_free
		end

invariant
	non_void_area: area /= Void
	area_not_null: area.item /= default_pointer

end -- class MEMORY_STREAM
