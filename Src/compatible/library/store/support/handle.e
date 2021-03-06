note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class HANDLE

feature -- Status report

	database: DB [DATABASE]
			-- Active database accessed through the handle
		require
			set: is_database_set
		local
			l_result: like internal_database
		do
			l_result := internal_database
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	process: POINTER_REF
			-- Communication channel with database server
			-- (single or multiple depending on RDBMS)
		require
			set: is_process_set
		local
			l_result: like internal_process
		do
			l_result := internal_process
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	status: DB_STATUS
			-- Status of active database
		require
			set: is_status_set
		local
			l_result: like internal_status
		do
			l_result := internal_status
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	execution_type: DB_EXEC
			-- Immediate or non-immediate execution		
		require
			set: is_execution_type_set
		local
			l_result: like internal_execution_type
		do
			l_result := internal_execution_type
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	login: LOGIN [DATABASE]
			-- Session login
		require
			set: is_login_set
		local
			l_result: like internal_login
		do
			l_result := internal_login
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	all_types: DB_ALL_TYPES
			-- All data types available in active database
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	is_database_set: BOOLEAN
			-- If `internal_database' attached?
		do
			Result := internal_database /= Void
		end

	is_process_set: BOOLEAN
			-- If `internal_process' attached?
		do
			Result := internal_process /= Void
		end

	is_status_set: BOOLEAN
			-- If `internal_status' attached?
		do
			Result := internal_status /= Void
		end

	is_execution_type_set: BOOLEAN
			-- If `internal_execution_type' attached?
		do
			Result := internal_execution_type /= Void
		end

	is_login_set: BOOLEAN
			-- If `internal_login' attached?
		do
			Result := internal_login /= Void
		end

feature {GENERAL_APPL} -- Status setting

	set_database (other: DB [DATABASE])
			-- Set current database with `other'.
  		require
			database_exists: other /= Void
		do
			internal_database := other
		ensure
			database = other
		end

	set_process (other: POINTER_REF)
			-- Set current process with `other'.
		do
			internal_process := other
		ensure
			process = other
		end

	set_status (other: DB_STATUS)
			-- Set current status with `other'.
		require
			db_status_exists: other /= Void
		do
			internal_status := other
		ensure
			status = other
		end

	set_execution_type (other: DB_EXEC)
			-- Set current execution_type with `other'.
		require
			db_status_exists: other /= Void
		do
			internal_execution_type := other
		ensure
			execution_type = other
		end

	set_login (other: LOGIN [DATABASE])
		-- Get `other' login for handle
		require
			login_not_void: other /= Void
		do
			internal_login := other
		ensure
			login = other
		end

feature {NONE} -- Implementation

	internal_database: detachable DB [DATABASE]
			-- Active database accessed through the handle

	internal_process: detachable POINTER_REF
			-- Communication channel with database server
			-- (single or multiple depending on RDBMS)

	internal_status: detachable DB_STATUS
			-- Status of active database

	internal_execution_type: detachable DB_EXEC
			-- Immediate or non-immediate execution		

	internal_login: detachable LOGIN [DATABASE]
			-- Session login

;note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HANDLE



