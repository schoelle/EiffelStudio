indexing
	description	: "Wizard Step."
	author		: "Generated by the Wizard wizard"
	revision	: "1.0.0"

class
	WIZARD_SECOND_STATE

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW	
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end
		
	GB_SHARED_SYSTEM_STATUS
	
	GB_NAMING_UTILITIES
	
	GB_CONSTANTS
	
	EIFFEL_RESERVED_WORDS

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		do
			if project_settings.complete_project then
					-- Not currently needed, but may be needed when different options specified.
				create application_class_name.make (Current)
				application_class_name.set_label_string_and_size ("Application class", 50)
				application_class_name.set_text (project_settings.application_class_name)
				application_class_name.generate
				choice_box.extend (application_class_name.widget)
			end			
			set_updatable_entries(<<>>)
		end

	proceed_with_current_info is
			-- User has clicked next, go to next step.
		do
			Precursor
			validate
			if validate_successful then
				proceed_with_new_state(create {WIZARD_THIRD_STATE}.make(wizard_information))	
			else
				proceed_with_new_state (create {GB_BUILD_CLASS_NAMES_ERROR_STATE}.make (wizard_information))
			end
		end
		
	validate_successful: BOOLEAN
		-- Was the last call to `validate', successful?
		
	validate is
			-- Validate input fields of `Current'.
		local
			application_name_lower: STRING
		do
			validate_successful := True

				-- If we are the project wizard, we need to check all three entries,
				-- otherwise, we only validate the class name
			if project_settings.complete_project then
				application_name_lower := application_class_name.text.as_lower
					-- Check for valid names/and or reserved words used.
				if not valid_class_name (application_name_lower) or
					reserved_words.has (application_name_lower) then
					validate_successful := False
				end
			end
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor {WIZARD_INTERMEDIARY_STATE_WINDOW}
			if project_settings.complete_project and valid_class_name (application_class_name.text) then
				project_settings.set_application_class_name (application_class_name.text)
			end
		end

feature {NONE} -- Implementation

	display_state_text is
			-- Set the messages for this state.
		do
			title.set_text ("System information")
			subtitle.set_text ("Enter system information.")
			message.set_text ("Enter the following system information:")
		end
	
	application_class_name: WIZARD_SMART_TEXT_FIELD

	project_settings: GB_PROJECT_SETTINGS is
			-- Access to the current project settings.
		do
			Result := system_status.current_project_settings
		end
		
end -- class WIZARD_SECOND_STATE
