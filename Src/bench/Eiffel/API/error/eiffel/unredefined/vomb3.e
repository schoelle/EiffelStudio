indexing

	description: 
		"Error when the is a conflict on values in an inspect expression.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB3 

inherit

	VOMB
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is 3;

	interval: INTERVAL_B;
			-- Interval of conflicting values

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Duplicate values: ");
			interval.display (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_interval (t: INTERVAL_B) is
			-- Assign `t' to `interval'.
		do
			interval := t;
		end;

end -- class VOMB3
