
class EBUILD 

inherit

	ARGUMENTS;

	WINDOWS
		export
			{NONE} all
		end;
	AUTO_SAVE
		rename
			command_line as exec_command_line
		export
			{NONE} all
		end;
	SHARED_LICENSE

feature 

	make is
		do
			!!init;
			init.perform_initial_check;
			if init.error then
				io.error.putstring ("EiffelBuild stopped%N");
				exit
			elseif init_licence then
				init_windowing;
				init_project;
				read_command_line;
				iterate;
				discard_licence
			end;
		rescue
			discard_licence;
			save_rescue
		end;
	
feature {NONE}

	init_licence: BOOLEAN is
		do
			licence.get_registration_info;
			licence.set_version (3);
			licence.set_application_name ("eiffelbuild");
			Result := licence.connected
		end;

	init: INIT_CHECK;
	
	read_command_line is
		local
			cmd: OPEN_PROJECT
		do
			if argument_count > 1 then
				!!cmd;
				cmd.execute (argument (1))
			end;
		end;

	retried: BOOLEAN;
	temp:INTEGER;

	save_rescue is
		do
			-- no_message_on_failure;
			if not retried then
				history_window.wipe_out;
				-- Force garbage collection
				if main_panel.project_initialized then
					auto_save;
				end
			else
				io.error.putstring ("EiffelBuild: internal error%N");	
			end;
		rescue
			retried := True;
			retry
		end;

end
