-- Node for type POINTER

class POINTER_TYPE_AS

inherit

	BASIC_TYPE

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): POINTER_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	dump: STRING is "POINTER";

	actual_type: POINTER_A is
			-- Actual pointer type
		once
			!!Result
		end;

end
