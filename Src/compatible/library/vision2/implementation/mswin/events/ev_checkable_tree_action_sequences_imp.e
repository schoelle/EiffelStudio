note
	description: "Action sequences for EV_CHECKABLE_TREE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE_ACTION_SEQUENCES_IMP

inherit
	EV_CHECKABLE_TREE_ACTION_SEQUENCES_I

feature -- Event handling

	create_check_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Create a select action sequence.
		do
			create Result
		end

	create_uncheck_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Create an uncheck action sequence.
		do
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

