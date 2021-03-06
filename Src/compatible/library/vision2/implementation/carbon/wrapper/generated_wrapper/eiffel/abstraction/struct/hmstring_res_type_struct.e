-- This file has been generated by EWG. Do not edit. Changes will be lost!

class HMSTRING_RES_TYPE_STRUCT

inherit

	EWG_STRUCT

	HMSTRING_RES_TYPE_STRUCT_EXTERNAL
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

	hmmresid: INTEGER is
			-- Access member `hmmResID'
		require
			exists: exists
		do
			Result := get_hmmresid_external (item)
		ensure
			result_correct: Result = get_hmmresid_external (item)
		end

	set_hmmresid (a_value: INTEGER) is
			-- Set member `hmmResID'
		require
			exists: exists
		do
			set_hmmresid_external (item, a_value)
		ensure
			a_value_set: a_value = hmmresid
		end

	hmmindex: INTEGER is
			-- Access member `hmmIndex'
		require
			exists: exists
		do
			Result := get_hmmindex_external (item)
		ensure
			result_correct: Result = get_hmmindex_external (item)
		end

	set_hmmindex (a_value: INTEGER) is
			-- Set member `hmmIndex'
		require
			exists: exists
		do
			set_hmmindex_external (item, a_value)
		ensure
			a_value_set: a_value = hmmindex
		end

end
