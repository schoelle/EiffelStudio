-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct BigEndianLong

class BIG_ENDIAN_LONG_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct BigEndianLong)"
		end

	get_bigendianvalue_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_BigEndianLong_member_get_bigEndianValue"
		end

	set_bigendianvalue_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_BigEndianLong_member_set_bigEndianValue"
		ensure
			a_value_set: a_value = get_bigendianvalue_external (an_item)
		end

end

