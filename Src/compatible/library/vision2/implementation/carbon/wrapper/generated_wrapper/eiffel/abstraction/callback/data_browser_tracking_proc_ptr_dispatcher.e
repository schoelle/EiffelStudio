-- This file has been generated by EWG. Do not edit. Changes will be lost!

class DATA_BROWSER_TRACKING_PROC_PTR_DISPATCHER

inherit

	ANY

	EWG_CARBON_CALLBACK_C_GLUE_CODE_FUNCTIONS_EXTERNAL
		export {NONE} all end

create

	make

feature {NONE}

	make (a_callback: DATA_BROWSER_TRACKING_PROC_PTR_CALLBACK) is
		require
			a_callback_not_void: a_callback /= Void
		do
			callback := a_callback
			set_data_browser_tracking_proc_ptr_entry_external (Current, $on_callback)
		end

feature {ANY}

	callback: DATA_BROWSER_TRACKING_PROC_PTR_CALLBACK

	c_dispatcher: POINTER is
		do
			Result := get_data_browser_tracking_proc_ptr_stub_external
		end

feature {NONE} -- Implementation

	frozen on_callback (a_browser: POINTER; a_itemid: INTEGER; a_property: INTEGER; a_therect: POINTER; a_startpt: POINTER; a_modifiers: INTEGER): INTEGER is 
		do
			Result := callback.on_callback (a_browser, a_itemid, a_property, a_therect, a_startpt, a_modifiers) 
		end

invariant

	 callback_not_void: callback /= Void

end