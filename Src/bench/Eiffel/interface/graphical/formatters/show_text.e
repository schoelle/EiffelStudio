indexing

	description:	
		"Command to display text. %
			%No warning or watch cursor.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_TEXT 

inherit

	FORMATTER
		rename
			display_header as format_display_header,
			class_name as exception_class_name
		redefine
			format, file_name, dark_symbol, display_temp_header
		end;
	FORMATTER
		rename
			class_name as exception_class_name
		redefine
			format, display_header, file_name, dark_symbol, display_temp_header
		select
			display_header
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
		do
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showtext 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showtext
		end;
	
feature {ROUTINE_WIN_MGR} -- Displaying

	display_header (stone: STONE) is
		local
			new_title: STRING;
			fs: FEATURE_STONE;
		do
			!!new_title.make (0);
			new_title.append (stone.header);
			fs ?= stone;
			if
				(fs /= Void) and then
				Application.has_breakpoint_set (fs.e_feature) 
			then
				new_title.append ("   (stop)");		
			end;
			tool.set_title (new_title);
		end;

feature -- Formatting

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text, class_name: STRING;
			filed_stone: FILED_STONE;
			classc_stone: CLASSC_STONE;
			e_class: E_CLASS;
			class_tool: CLASS_W;
			modified_class: BOOLEAN;
			retried: BOOLEAN;
			same_stone, error: BOOLEAN;
			mp: MOUSE_PTR;
			cur: CURSOR
		do
			if not retried then
				classc_stone ?= stone;
				if 
					classc_stone /= Void and then classc_stone.is_valid
				then
					e_class := classc_stone.e_class;
					if
						not e_class.is_precompiled
					and then
						e_class.lace_class.date_has_changed
					then
						modified_class := true
					end;
				end;
				if
					do_format or filtered or modified_class or else
					(tool.last_format.associated_command /= Current or
					not stone.same_as (tool.stone))
				then
					if stone /= Void and then stone.is_valid then
						same_stone := equal (stone, tool.stone);
						display_temp_header (stone);
						!! mp.set_watch_cursor;
						stone_text := stone.origin_text;
						if stone_text = Void then
							stone_text := "";
							filed_stone ?= stone;
							if filed_stone /= Void then
								if filed_stone.file_name /= Void then
									error := true;
									warner (popup_parent).gotcha_call 	
									(w_Cannot_read_file (filed_stone.file_name))
								else
									error := true;
									warner (popup_parent).gotcha_call 
										(w_No_associated_file)
								end;
							end			
						end;
						text_window.clear_window;
						tool.set_editable_text;
						filed_stone ?= stone;
						if filed_stone /= Void then
							tool.set_file_name (file_name (filed_stone));
						end;
						tool.set_stone (stone);
						text_window.set_text (stone_text);
						tool.show_editable_text;
						if stone.clickable then
							if modified_class then
								if not error and not do_format then
										-- Do not display the warning message
										-- if the format has been changed
										-- internally (resynchronization, ...)
									class_name := classc_stone.e_class.name;
									error := true;
									warner (popup_parent).gotcha_call 
										(w_Class_modified (class_name))
								end
							else
								text_window.update_clickable_from_stone
							end
						end;
						class_tool ?= tool;
						if 
							class_tool /= Void and then (
							(same_stone and tool.last_format = 
										class_tool.showclick_frmt_holder) or
							(do_format and tool.last_format.associated_command = Current))
						then
							cur := text_window.cursor;
						end;
						if cur /= Void then
							text_window.go_to (cur)
						end;
						tool.set_last_format (holder);
						display_header (stone);
						mp.restore
					end;
					filtered := false
				end
			else
				!! mp.do_nothing;
				mp.restore
				warner (popup_parent).gotcha_call (w_Cannot_retrieve_info);
			end
		rescue
			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true;
				retry
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if tool.last_format.associated_command = Current then
				tool.set_title ("Producing text format...")
			else
				tool.set_title ("Switching to text format...")
			end
		end;

	display_info (d: STONE) is do end
			-- Useless here

feature {NONE} -- Properties

	file_name (s: FILED_STONE): STRING is
		do
			Result := s.file_name
		end;

	name: STRING is
		do
			Result := l_Showtext
		end;

	title_part: STRING is
		do
			Result := ""
		end;

end -- SHOW_TEXT
