indexing

	description: 
		"Abstract description of error in third pass.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_NAME_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace
		end;

feature -- Properties

	feature_name:  STRING;
			-- Feature involved in the error
			-- [if Void it is in the invariant]

feature -- Output

	trace (st: STRUCTURED_TEXT) is
		do
			print_error_message (st);
			st.add_string ("Class: ");
			e_class.append_signature (st);
			if feature_name /= Void then
				st.add_string ("%NFeature name: ");
				st.add_string (feature_name);
				st.add_new_line;
			else
				st.add_string ("%NFeature: invariant%N");
			end;
			build_explain (st);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `f' to `feature'.
		do
			feature_name := s;
		end;

end -- class FEATURE_NAME_ERROR
