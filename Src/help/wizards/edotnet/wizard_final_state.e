indexing
	description	: "Final state of the wizard."

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			make,
			fill_message_and_title_box,
			build
		end

create
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_FINAL_STATE_WINDOW} (an_info) 
		end

feature -- Basic Operations

	build is
			-- Special display box for the first and the last state
		do
			create message_text_field
			message_text_field.set_background_color (white_color)

			Precursor
		end

	proceed_with_current_info is
		do
			project_generator.generate_code
			write_bench_notification_ok (wizard_information)
			Precursor
		end

feature -- Access

	display_state_text is
			-- Display message text relative to current state.
		local
			word: STRING
		do
			title.set_text (Interface_names.m_Final_title)
			if wizard_information.compile_project then
				word := Space + Text_if_compile + Space
			else
				word := Space
			end
			message_text_field.set_text (Common_message)
			message.set_text (final_state_message (word))
		end

	final_message: STRING is
		do
		end

	final_state_message (a_word: STRING): STRING is
			-- Final state message according to `a_word'
		require
			non_void_word: a_word /= Void
		do
			Result := "Click Finish to generate" + a_word + "this project."
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end

feature {NONE} -- Widgets

	message_text_field: EV_TEXT
			-- Text field summarizing the project settings

	instruction: EV_LABEL
			-- Message telling the user how to launch code generation and compilation

feature {NONE} -- Implementation

	message_text: STRING
			-- Final message 

	fill_message_and_title_box (message_and_title_box: EV_VERTICAL_BOX) is
			-- Fill `message_and_title_box' with needed widgets.
		do
			message_and_title_box.extend (message_text_field) -- Expandable item
			message_and_title_box.extend (message)
			message_and_title_box.disable_item_expand (message)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string (Wizard_icon_name)
			 Result.add_extension (pixmap_extension)
		end

feature {NONE} -- Constants

	h_filename: STRING is "help/wizards/edotnet/docs/reference/40_settings_summary/index.html"
			-- Path to HTML help file

	Common_message: STRING is 
			-- Message to the user (no matter if there are selected assemblies)
		local
			creation_routine_name: STRING
		do
			create Result.make (3000)
			Result.append ("You have specified the following settings:" + New_line + New_line +
					"Project name: " + Tab + wizard_information.project_name + New_line +
					"Location: " + Tab + wizard_information.project_location + New_line +
					"Application type: " + Tab)
			if wizard_information.generate_dll then
				Result.append ("Library (.dll)")
			else
				Result.append ("Application (.exe)")
			end
			Result.append (New_line)
			Result.append ("Console application: " + Tab)
			if wizard_information.console_application then
				Result.append ("Yes")
			else
				Result.append ("No")
			end

			Result.append (New_line + New_line)
			Result.append ("Root class name: " + Tab + wizard_information.root_class_name + New_line)
			creation_routine_name := wizard_information.creation_routine_name
			if creation_routine_name /= Void and then not creation_routine_name.is_empty and then not creation_routine_name.is_equal (Unrelevant_data) then
				Result.append ("Creation routine name: " + Tab + wizard_information.creation_routine_name + New_line)
			end
			Result.append (New_line)
			Result.append ("Target CLR version: " + Tab + wizard_information.clr_version + New_line)
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end	

	Space: STRING is " "
			-- Space

	Text_if_compile: STRING is "and compile"
			-- Text appended to the current state text in case the user asked for project compilation

end -- class WIZARD_FINAL_STATE
