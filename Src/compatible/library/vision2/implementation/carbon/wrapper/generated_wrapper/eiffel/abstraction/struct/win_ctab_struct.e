-- This file has been generated by EWG. Do not edit. Changes will be lost!

class WIN_CTAB_STRUCT

inherit

	EWG_STRUCT

	WIN_CTAB_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	wcseed: INTEGER is
			-- Access member `wCSeed'
		require
			exists: exists
		do
			Result := get_wcseed_external (item)
		ensure
			result_correct: Result = get_wcseed_external (item)
		end

	set_wcseed (a_value: INTEGER) is
			-- Set member `wCSeed'
		require
			exists: exists
		do
			set_wcseed_external (item, a_value)
		ensure
			a_value_set: a_value = wcseed
		end

	wcreserved: INTEGER is
			-- Access member `wCReserved'
		require
			exists: exists
		do
			Result := get_wcreserved_external (item)
		ensure
			result_correct: Result = get_wcreserved_external (item)
		end

	set_wcreserved (a_value: INTEGER) is
			-- Set member `wCReserved'
		require
			exists: exists
		do
			set_wcreserved_external (item, a_value)
		ensure
			a_value_set: a_value = wcreserved
		end

	ctsize: INTEGER is
			-- Access member `ctSize'
		require
			exists: exists
		do
			Result := get_ctsize_external (item)
		ensure
			result_correct: Result = get_ctsize_external (item)
		end

	set_ctsize (a_value: INTEGER) is
			-- Set member `ctSize'
		require
			exists: exists
		do
			set_ctsize_external (item, a_value)
		ensure
			a_value_set: a_value = ctsize
		end

	cttable: POINTER is
			-- Access member `ctTable'
		require
			exists: exists
		do
			Result := get_cttable_external (item)
		ensure
			result_correct: Result = get_cttable_external (item)
		end

end