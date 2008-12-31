note
	description	: "Main window for this application"
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date$"
	revision	: "1.0.0"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	docking_manager: SD_DOCKING_MANAGER

	initialize
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

				-- Create and add the status bar.
			build_standard_status_bar
			lower_bar.extend (standard_status_bar)

			create main_container
			extend (main_container)

			create docking_manager.make (main_container, Current)
			docking_manager.close_editor_place_holder
			build_tools

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window
			set_title (Window_title)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)
		end

	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end

feature -- Element change

	add_melted_filename (fn: STRING)
		require
			fn_attached: fn /= Void
		local
			fns: LINKED_LIST [STRING_32]
			f: RAW_FILE
		do
			create f.make (fn)
			if f.exists and then f.is_readable then
				create fns.make
				fns.extend (fn)
				on_files_dropped (fns)
			end
		end

feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window

	standard_status_label: EV_LABEL
			-- Label situated in the standard status bar.
			--
			-- Note: Call `standard_status_label.set_text (...)' to change the text
			--       displayed in the status bar.

	build_standard_status_bar
			-- Create and populate the standard toolbar.
		require
			status_bar_not_yet_created:
				standard_status_bar = Void and then
				standard_status_label = Void
		do
				-- Create the status bar.
			create standard_status_bar
			standard_status_bar.set_border_width (2)

				-- Populate the status bar.
			create standard_status_label.make_with_text ("Add your status text here...")
			standard_status_label.align_text_left
			standard_status_bar.extend (standard_status_label)
		ensure
			status_bar_created:
				standard_status_bar /= Void and then
				standard_status_label /= Void
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
					--| TODO: Remove this line if you don't want the application
					--|       to end when the first window is closed..
				(create {EV_ENVIRONMENT}).application.destroy
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	build_tools
			--
		local
			c0,c1,c2,c3: SD_CONTENT
			g: EV_GRID
			t: EV_TEXT
		do
			create g
			create c0.make_with_widget (g, "select...")
			c0.set_short_title ("Drop *.melted below ...")
			c0.set_long_title ("Drop *.melted below ...")
			docking_manager.contents.extend (c0)
			c0.set_top ({SD_ENUMERATION}.top)
			selection_grid := g
			selection_grid_content := c0

			create t
			create c1.make_with_widget (t, "melted")
			c1.set_short_title ("Melted")
			c1.set_long_title ("Melted")
			docking_manager.contents.extend (c1)
			c1.set_relative (c0 , {SD_ENUMERATION}.bottom)
			melted_text := t

			create g
			g.enable_tree
--			g.disable_row_height_fixed
			g.enable_single_row_selection
			bytecode_grid := g

			create c2.make_with_widget (g, "bytecode")
			c2.set_short_title ("Bytecode")
			c2.set_long_title ("Bytecode")
			docking_manager.contents.extend (c2)
			c2.set_tab_with (c1 , True)

			create t
			bytecode_text := t
			create c3.make_with_widget (t, "bytecode_details")
			c3.set_short_title ("Bytecode ...")
			c3.set_long_title ("Bytecode ...")
			docking_manager.contents.extend (c3)
			c3.set_relative (c2, {SD_ENUMERATION}.right)


			selection_grid.set_row_count_to (0)
			selection_grid.enable_tree
			selection_grid.enable_single_row_selection
			selection_grid.file_drop_actions.extend (agent on_files_dropped)
			selection_grid.row_select_actions.extend (agent on_row_selected)
			selection_grid.hide_header

			show_actions.extend_kamikaze (agent (ac0,ac1,ac2: SD_CONTENT)
					do
						ac0.set_split_proportion (0.3)
						ac1.set_split_proportion (0.5)
						ac2.set_split_proportion (0.5)
					end (c0, c1, c2)
				)
		end

	selection_grid_content: SD_CONTENT

	selection_grid: EV_GRID
	melted_text: EV_TEXT
	bytecode_text: EV_TEXT
	bytecode_grid: EV_GRID

	on_files_dropped (fns: LIST [STRING_32])
			--
		local
			s, fn: STRING_GENERAL
			gl: EV_GRID_LABEL_ITEM
		do
			if fns /= Void and then fns.count > 0 then
				if ev_application.ctrl_pressed then
					selection_grid.set_row_count_to (0)
				end
				from
					fns.start
				until
					fns.after
				loop
					fn := fns.item
					create gl.make_with_text (fn)
					selection_grid.set_item (1, selection_grid.row_count + 1, gl)
					gl.row.set_data (fn)
					fns.forth
				end
			end
			if selection_grid.column_count > 0 then
				selection_grid.column (1).resize_to_content
			end
			if selection_grid.row_count = 1 then
				s ?= selection_grid.row (1).data
				if s /= Void then
					process_filename (s)
				end
			end
		end

	on_row_selected	(r: EV_GRID_ROW)
			--
		local
			s: STRING_GENERAL
		do
			if r /= Void then
				s ?= r.data
				process_filename (s)
			end
		end

	process_filename (s: STRING_GENERAL)
			--
		local
			fn: FILE_NAME
			t: STRING
			f: PLAIN_TEXT_FILE
			nfn: FILE_NAME
			wd: STRING
		do
			if s /= Void then
				selection_grid_content.minimize
				create fn.make_from_string (s.to_string_8)
				if fn.is_valid then
					create wd.make_from_string (fn)
					wd.keep_head (wd.last_index_of (operating_environment.directory_separator, wd.count))

					create f.make (fn)
					if f.exists and then f.is_readable then
						standard_status_label.set_text ("loading file %"" + s.out + "%""); standard_status_label.refresh_now
						set_pointer_style ((create {EV_STOCK_PIXMAPS}).Busy_cursor)
						standard_status_label.set_text ("meltdump ..."); standard_status_label.refresh_now
						nfn := process_meltdump (fn, wd)
						t := content_of (nfn)
						t.prune_all ('%R')
						melted_text.set_text (t)

						create nfn.make_from_string (wd)
						nfn.set_file_name ("bytecode")
						nfn.add_extension ("eif")
						standard_status_label.set_text ("bytedump ..."); standard_status_label.refresh_now
						nfn := process_bytedump (nfn, wd)
						standard_status_label.set_text ("Analyze bytecode ..."); standard_status_label.refresh_now
						analyze_bytecode_from (nfn)
						standard_status_label.set_text ("Display bytecode ..."); standard_status_label.refresh_now
						fill_bytecode_tool
						standard_status_label.set_text ("Terminated."); standard_status_label.refresh_now
						set_pointer_style ((create {EV_STOCK_PIXMAPS}).Standard_cursor)
					end
				end
			end
		end


	analyze_bytecode_from (fn: STRING)
			--
		local
			f: RAW_FILE
			line, src: STRING
			h,b: STRING
			e: like analyzes_entry
		do
			analyzes := Void
			create f.make (fn)
			if f.exists then
				f.open_read
				from
					create analyzes.make
					f.read_line
					line := f.last_string
				until
					f.end_of_file or line = Void
				loop
					if line.has_substring (once "1: BC_START") then
						create e
						analyzes.extend (e)
						create h.make_empty
						create b.make_empty
						e.header := h
						e.body := b
						b.append (line)
						b.append_character ('%N')
						from
							f.read_line
							line.left_adjust
						until
							line = Void
							or else line.item (1).is_digit
							or f.end_of_file
						loop
							h.append (line)
							h.append_character ('%N')
							if e.rout_id = 0 and then string_started_by (line, "Routine Id", False) then
								e.rout_id := line.substring (line.index_of (':', 1) + 1, line.count).to_integer_32
							elseif e.body_id = 0 and then string_started_by (line, "Body Id", False) then
								e.body_id := line.substring (line.index_of (':', 1) + 1,  line.count).to_integer_32
							elseif e.name = Void and then string_started_by (line, "Routine name", False) then
								e.name := line.substring (line.index_of (':', 1) + 1, line.count)
							else
							end
							f.read_line
							line.left_adjust
						end
						from
							f.read_line
							src := line.twin
							line.left_adjust
						until
							line = Void
							or else line.is_empty
							or f.end_of_file
						loop
							b.append (src)
							b.append_character ('%N')
							f.read_line
							src := line.twin
							line.left_adjust
						end
						f.readline
					end
					f.read_line
					line.left_adjust
				end
				f.close
			end
		end

	fill_bytecode_tool
			--
		require
		local
			e: like analyzes_entry
			glab: EV_GRID_LABEL_ITEM
			r: EV_GRID_ROW
		do
			bytecode_grid.set_row_count_to (0)
			if analyzes = Void then
				create glab.make_with_text ("Error during analysis.")
				bytecode_grid.set_item (1, bytecode_grid.row_count + 1, glab)
			else
				from
					analyzes.start
				until
					analyzes.after
				loop
					e := analyzes.item
					create glab.make_with_text (e.name)
					bytecode_grid.set_item (1, bytecode_grid.row_count + 1, glab)
					r := bytecode_grid.row (bytecode_grid.row_count)
					r.set_data (e)

					create glab.make_with_text (e.rout_id.out)
					r.set_item (2, glab)
					create glab.make_with_text (e.body_id.out)
					r.set_item (3, glab)

	--				r.insert_subrows (2, 1)
	--				create glab.make_with_text (e.header)
	--				r.subrow (1).set_item (2, glab)
	--				r.subrow (1).set_height (glab.text_height)
	--				create glab.make_with_text (e.body)
	--				r.subrow (2).set_item (2, glab)
	--				r.subrow (2).set_height (glab.text_height)

					r.select_actions.extend (agent (ar: EV_GRID_ROW)
							local
								le: like analyzes_entry
								t: STRING
							do
								le ?= ar.data
								if le /= Void then
									t := le.header + "%N" + le.body
									t.prune_all ('%R')
									bytecode_text.set_text (t)
								else
									bytecode_text.remove_text
								end
							end(r)
						)
					analyzes.forth
				end
			end
		end


	analyzes: LINKED_LIST [like analyzes_entry]
	analyzes_entry: TUPLE [rout_id: INTEGER; body_id: INTEGER; name: STRING; header: STRING; body: STRING]
			--
		do

		end


	string_started_by (s: STRING_GENERAL; pre: STRING_GENERAL; b: BOOLEAN): BOOLEAN
			--
		local
			i: INTEGER
		do
			Result := s.count >= pre.count
			from
				i := 1
			until
				i > pre.count or not Result
			loop
				Result := s.code (i) = pre.code (i)
				i := i + 1
			end
		end

	bad_string_started_by (s: STRING; a_prefix: STRING; a_is_entire: BOOLEAN): BOOLEAN
			-- Is string `s' started by `a_prefix' string ?
			-- (first blanks are ignored)
		require
			s /= Void
		local
			i,j: INTEGER
		do
			if a_prefix /= Void and then s.count >= a_prefix.count then
				from
					i := 1
					j := 1
					Result := True
				until
					not Result or j > a_prefix.count
				loop

					if s.item (i) /= ' ' then
						Result := s.item (i).as_lower = a_prefix.item (j).as_lower
						j := j + 1
					end
					i := i + 1
				end
			end
			if Result and a_is_entire then
				Result := s.count = a_prefix.count or else s.item (a_prefix.count + 1).is_space
			end
		end

	process_bytedump (fn: FILE_NAME; wd: STRING): FILE_NAME
			--
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			exefn: FILE_NAME
			cmd: STRING
		do
			create pf
			create exefn.make_from_string ((create {EXECUTION_ENVIRONMENT}).get ("EIFFEL_SRC"))
			exefn.extend ("C")
			exefn.extend ("bench")
			exefn.set_file_name ("bytedump")
			if extension_exe /= Void then
				exefn.add_extension (extension_exe)
			end

			create cmd.make_from_string (exefn)
			cmd.append (" ")
			cmd.append (fn)
			create Result.make_from_string (wd)
			Result.set_file_name ("bytecode")
			Result.add_extension ("txt")
			p := pf.process_launcher_with_command_line (cmd, wd)
			p.set_hidden (True)
			p.launch
			p.wait_for_exit
		end

	process_meltdump (fn: FILE_NAME; wd: STRING): FILE_NAME
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			exefn: FILE_NAME
			cmd: STRING
		do
			create pf
			create exefn.make_from_string ((create {EXECUTION_ENVIRONMENT}).get ("EIFFEL_SRC"))
			exefn.extend ("C")
			exefn.extend ("bench")
			exefn.set_file_name ("meltdump")
			if extension_exe /= Void then
				exefn.add_extension (extension_exe)
			end
			create cmd.make_from_string (exefn)
			cmd.append (" ")
			cmd.append (fn)
			create Result.make_from_string (wd)
			Result.set_file_name ("melted")
			Result.add_extension ("txt")
			p := pf.process_launcher_with_command_line (cmd, wd)
			p.set_hidden (True)
			p.launch
			p.wait_for_exit
		end

	extension_exe: STRING
		local
			pl: PLATFORM
		once
			create pl
			if pl.is_windows then
				Result := "exe"
			end
		end

	content_of (fn: FILE_NAME): STRING
		local
			f: RAW_FILE
		do
			create f.make (fn)
			if f.exists then
				f.open_read
				create Result.make_empty
				from
					f.start
				until
					f.exhausted
				loop
					f.read_stream (512)
					Result.append_string (f.last_string)
				end
				f.close
			else
				Result := "Unable to open file %"" + fn + "%""
			end
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING = "bytecode_tool"
			-- Title of the window.

	Window_width: INTEGER = 400
			-- Initial width for this window.

	Window_height: INTEGER = 400
			-- Initial height for this window.

end -- class MAIN_WINDOW
