-- Meting information for a feature

class FEAT_MELTED_INFO 

inherit

	MELTED_INFO

creation

	make
	
feature 

	feature_name: STRING;
			-- Feature to melt

	make (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void
		do
			feature_name := f.feature_name;
		end;

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
            -- Associated feature
        do
            check
                consistency: feat_tbl.has (feature_name)
            end;
            Result := feat_tbl.item (feature_name)
        end;

end
