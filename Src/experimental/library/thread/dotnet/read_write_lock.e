note
	description: "Read/Write synchronization object, allows multiple reader threads to have %
		%access to a resource, and only one writer thread."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	READ_WRITE_LOCK

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create
			-- Create read/write lock.
		obsolete
			"Use make instead"
		require else
			thread_capable: {PLATFORM}.is_thread_capable
		do
			make
		ensure then
			item_set: is_set
		end

	make
			-- Create read/write lock.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			create item.make
			is_set := True
		ensure
			item_set: is_set
		end

feature -- Access

	is_set: BOOLEAN
			-- Is read/write lock initialized?

feature -- Status setting

	acquire_read_lock
			-- Lock current on a read.
		require
			exists: is_set
		do
				-- (-1) to force an infinite wait.
			item.acquire_reader_lock (-1)
		end

	acquire_write_lock
			-- Lock current on a write.
		require
			exists: is_set
		do
				-- (-1) to force an infinite wait.
			item.acquire_writer_lock (-1)
		end

	release_read_lock
			-- Unlock Reader lock.
		require
			exists: is_set
		do
			item.release_reader_lock
		end

	release_write_lock
			-- Unlock writer lock.
		require
			exists: is_set
		do
				-- We do not use `item.release_writer_lock' because when calling this routine
				-- we must have the lock, in which case the documentation states that it calls
				-- `item.release_writer_lock'. This is consistent with our implementation for classic Eiffel.
			item.release_reader_lock
		end

	destroy
			-- Destroy read/write lock.
		require
			exists: is_set
		do
			is_set := False
		end

feature -- Obsolete

	release_reader_lock, release_writer_lock
			-- Unlock Reader or Writer lock.
		obsolete
			"Use `release_read_lock' or `release_write_lock'."
		require
			exists: is_set
		do
			item.release_reader_lock
		end

feature {NONE} -- Implementation

	item: READER_WRITER_LOCK;
			-- Underlying .NET object.

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class READ_WRITE_LOCK

