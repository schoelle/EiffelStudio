indexing

	description:	
		"Retarget the tool with the next target in history.";
	date: "$Date$";
	revision: "$Revision$"

class NEXT_TARGET

inherit

	ICONED_COMMAND
		redefine
			execute
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as loose_changes
		end

creation

	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (a_text_window)
		end;

feature -- Callbacks

	execute_warner_help is
		do
		end;

	loose_changes (argument: ANY) is
			-- The changes will be lost.
		do
			text_window.disable_clicking;
			execute_licenced (Void)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Symbol for the button
		once
			Result := bm_Next_target
		end;

	name: STRING is
			-- Name of the command
		do
			Result := l_Next_target
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command, with parameter `argument'.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if not text_window.changed then
				execute_licenced (argument)
			else
				warner (popup_parent).call (Current, l_File_changed)
			end
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
		do
			history := tool.history;
			if history.empty or else (history.islast or history.after) then
				warner (popup_parent).gotcha_call (w_End_of_history)
			else
				history.forth;
				tool.last_format.execute (history.item)
			end
		end;

end -- class NEXT_TARGET
