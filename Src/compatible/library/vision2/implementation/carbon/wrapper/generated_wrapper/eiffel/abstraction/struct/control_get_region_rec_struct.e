-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CONTROL_GET_REGION_REC_STRUCT

inherit

	EWG_STRUCT

	CONTROL_GET_REGION_REC_STRUCT_EXTERNAL
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

	region_struct: OPAQUE_RGN_HANDLE_STRUCT is
			-- Access member `region'
		require
			exists: exists
		do
			create Result.make_shared (get_region_external (item))
		ensure
			result_not_void: Result /= Void
			result_has_correct_item: Result.item = region
		end

	set_region_struct (a_value: OPAQUE_RGN_HANDLE_STRUCT) is
			-- Set member `region'
		require
			a_value_not_void: a_value /= Void
			exists: exists
		do
			set_region_external (item, a_value.item)
		ensure
			a_value_set: a_value.item = region
		end

	region: POINTER is
			-- Access member `region'
		require
			exists: exists
		do
			Result := get_region_external (item)
		ensure
			result_correct: Result = get_region_external (item)
		end

	set_region (a_value: POINTER) is
			-- Set member `region'
		require
			exists: exists
		do
			set_region_external (item, a_value)
		ensure
			a_value_set: a_value = region
		end

	part: INTEGER is
			-- Access member `part'
		require
			exists: exists
		do
			Result := get_part_external (item)
		ensure
			result_correct: Result = get_part_external (item)
		end

	set_part (a_value: INTEGER) is
			-- Set member `part'
		require
			exists: exists
		do
			set_part_external (item, a_value)
		ensure
			a_value_set: a_value = part
		end

end
