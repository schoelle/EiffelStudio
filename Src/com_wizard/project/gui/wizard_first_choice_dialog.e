indexing 
	description: "WIZARD_FIRST_CHOICE_DIALOG class created by Resource Bench."

class 
	WIZARD_FIRST_CHOICE_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			setup_dialog,
			on_ok,
			parent,
			on_control_command
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_EXECUTION_ENVIRONMENT

	WEL_HELP_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: MAIN_WINDOW) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Wizard_first_choice_dialog_constant)
			create open_project_radio.make_by_id (Current, Open_project_check_constant)
			create create_project_from_com_radio.make_by_id (Current, Create_project_from_com_check_constant)
			create create_project_from_eiffel_class_radio.make_by_id (Current, Create_project_from_eiffel_check_constant)
			create id_ok.make_by_id (Current, Idok)
			create id_cancel.make_by_id (Current, Idcancel)
			create help_button.make_by_id (Current, Help_button_constant)
			create id_back.make_by_id (Current, Id_back_constant)
			create welcome_static.make_by_id (Current, Title_static_constant)
			help_topic_id := 731

			shared_wizard_environment.set_new_project (False)
		end

feature -- Behavior

	setup_dialog is
			-- Disable back button and setup buttons.
		do
			id_back.disable
			if shared_wizard_environment.new_project then
				open_project_radio.disable
				create_project_from_com_radio.set_checked
			else
				open_project_radio.set_checked
			end
			welcome_static.set_font (welcome_font)
			id_ok.set_focus
		end

	on_ok is
			-- Record values of buttons.
		do
			if create_project_from_com_radio.checked then
				shared_wizard_environment.set_new_eiffel_project (False)
				shared_wizard_environment.set_new_project (True)
			elseif create_project_from_eiffel_class_radio.checked then
				shared_wizard_environment.set_new_eiffel_project (True)
				shared_wizard_environment.set_new_project (True)
			else
				shared_wizard_environment.set_new_eiffel_project (False)
				shared_wizard_environment.set_new_project (False)
			end
			Precursor {WEL_MODAL_DIALOG}
		end

	on_help is
			-- Invoce Help.
		local
			tmp_help_path: STRING			
		do
			tmp_help_path := Eiffel4_location.twin
			tmp_help_path.append ("\wizards\com\eiffelcom.hlp")
			win_help (tmp_help_path, Help_context, help_topic_id)
		end

	on_control_command (control: WEL_CONTROL) is
			-- A command has been received from `control'.
		do
			if control = help_button then
				on_help
			elseif control = id_back then
				terminate (Idcancel)
			end
		end

feature -- Access

	open_project_radio: WEL_RADIO_BUTTON
			-- Open existing project button

	create_project_from_com_radio: WEL_RADIO_BUTTON
			-- Create new project from COM definition file button
	
	create_project_from_eiffel_class_radio: WEL_RADIO_BUTTON
			-- Create new project from Eiffel class button

	welcome_static: WEL_STATIC
			-- Welcome message static
			
	id_ok: WEL_PUSH_BUTTON
			-- Next button
			
	id_cancel: WEL_PUSH_BUTTON
			-- Cancel button
			
	help_button: WEL_PUSH_BUTTON
			-- Help button
			
	id_back: WEL_PUSH_BUTTON
			-- Back (greyed) button

	help_topic_id: INTEGER
			-- Topic ID for Help

	parent: MAIN_WINDOW
			-- Parent window

	welcome_font: WEL_FONT is
			-- Welcome message font
		once
			create Result.make_indirect (welcome_log_font)
		end

	welcome_log_font: WEL_LOG_FONT is
			-- Welcome message log font
		once
			create Result.make (Welcome_font_size, Welcome_font_face_name)
			Result.set_weight (Welcome_font_weight)
		end

	Welcome_font_size: INTEGER is 14
			-- Welcome message font size

	Welcome_font_face_name: STRING is "Verdana"
			-- Welcome message font face name

	Welcome_font_weight: INTEGER is 800
			-- Welcome message font weight

end -- class WIZARD_FIRST_CHOICE_DIALOG

--|-------------------------------------------------------------------
--| This class was automatically generated by Resource Bench
--| Copyright (C) 1996-1997, Interactive Software Engineering, Inc.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------
