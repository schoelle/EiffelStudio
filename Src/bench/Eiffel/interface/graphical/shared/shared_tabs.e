indexing

	description:	
		"Shared tabulatr information.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_TABS

inherit

	SHARED_BENCH_RESOURCES

feature -- Properties

	tabs_disabled: BOOLEAN is
			-- Is the tabulation mecanism disabled?
		local
			tabs_resource: STRING
		once
			--Result := resources.get_boolean (r_Tabs_disabled, False);
			---******* FIXME
			Result := True
		end;

	default_tab_length: INTEGER_REF is
			-- Default tabulation length
		local
			tab_integer: INTEGER
		once
			!!Result;
			tab_integer := resources.get_integer (r_Tab_step, Default_tab_step);
			if valid_tab_step (tab_integer) then
				Result.set_item (tab_integer)
			else
				Result.set_item (Default_tab_step)
			end
		end;

	Minimum_step: INTEGER is 2;
			-- Minimum length for a tab

	Maximum_step: INTEGER is 16;
			-- Maximum length for a tab

	Default_tab_step: INTEGER is 4;

	valid_tab_step (step: INTEGER): BOOLEAN is
			-- Is `step' a valid tabulation length?
		do
			Result := tabs_disabled or 
				(step >= Minimum_step and step <= Maximum_step)
		end;

feature -- Settings

	set_default_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `default_tab_length'.
		require
			valid_length: valid_tab_step (new_length)
		do
			default_tab_length.set_item (new_length)
		ensure
			assigned: default_tab_length.item = new_length
		end;

invariant

	valid_default_tab_step: valid_tab_step (Default_tab_step)

end -- class SHARED_TABS
