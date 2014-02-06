note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GROUP_SPINNER_IMP

inherit
	EV_RIBBON_GROUP

feature {NONE} -- Initialization

	create_interface_objects
			-- Create objects
		do
			create spinner.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.spinner>>)
			create spinner_query_value_button.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.spinner_query_value_button>>)

			create buttons.make (1)
			buttons.extend (spinner)
			buttons.extend (spinner_query_value_button)

		end

feature -- Query

	spinner: SPINNER
	spinner_query_value_button: SPINNER_QUERY_VALUE_BUTTON


end

