-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct EventTypeSpec

class EVENT_TYPE_SPEC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct EventTypeSpec)"
		end

	get_eventclass_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_EventTypeSpec_member_get_eventClass"
		end

	set_eventclass_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_EventTypeSpec_member_set_eventClass"
		ensure
			a_value_set: a_value = get_eventclass_external (an_item)
		end

	get_eventkind_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_EventTypeSpec_member_get_eventKind"
		end

	set_eventkind_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_EventTypeSpec_member_set_eventKind"
		ensure
			a_value_set: a_value = get_eventkind_external (an_item)
		end

end
