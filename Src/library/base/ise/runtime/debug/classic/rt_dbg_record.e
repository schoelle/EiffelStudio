indexing
	description: "Abstract record for execution recording mechanism"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_RECORD

inherit
	DEBUG_OUTPUT

	RT_DBG_COMMON

feature -- Properties

	position: INTEGER assign set_position
			-- Position of record.

	type: INTEGER assign set_type
			-- Type of record value.

	backup: RT_DBG_RECORD assign set_backup
			-- Backup value after restore operation

feature -- Access

	debug_output: STRING is
		do
			Result := "#" + position.out + " = " + to_string
		end

	is_same_as (other: RT_DBG_RECORD): BOOLEAN is
			-- Is Current same as `other' ?
		do
			Result := position = other.position
			check same_type: Result implies type = other.type end
		end

	to_string: STRING is
		deferred
		end

feature -- Change properties

	set_position (v: like position) is
			-- Set `position'
		do
			position := v
		end

	set_type (v: like type) is
			-- Set `type'
		do
			type := v
		end

	set_backup (v: like backup) is
			-- Set `backup'
		do
			backup := v
		end

feature -- Runtime

	restore (obj: ANY; bak: RT_DBG_RECORD) is
			-- Restore Current on target `obj',
			-- and associate the backup value to `bak'
		require
			no_backup: backup = Void
		deferred
		end

	revert (obj: ANY) is
			-- Revert previous `restore' using the associated `backup' value
		deferred
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
