indexing
	description: "Objects that represent action sequences for EV_GRID_ROW."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ROW_ACTION_SEQUENCES
	
inherit
	REFACTORING_HELPER

feature -- Access

-- Note that these are commented as they have been moved to EV_GRID_ACTION_SEQUENCES
-- Review this class and possibly remove if no action sequences are to be available at the row level.

	review is
			--
		do
			fixme ("dfg")
		end
		
	
--	expand_actions: EV_NOTIFY_ACTION_SEQUENCE is
--			-- Actions to be performed when `Current' is expanded.
--		do
--	--		Result := implementation.expand_actions
--		ensure
--			result_not_void: Result /= Void
--		end
--	
--	collapse_actions: EV_NOTIFY_ACTION_SEQUENCE is
--			-- Actions to be performed when `Current' is collapsed.
--		do
--	--		Result := implementation.collapse_actions
--		ensure
--			result_not_void: Result /= Void
--		end
--		
--feature {NONE} -- Implementation
--
--	implementation: EV_GRID_ROW_ACTION_SEQUENCES_I

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
