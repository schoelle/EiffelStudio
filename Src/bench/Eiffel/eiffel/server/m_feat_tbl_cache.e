-- Cache for melted feature tables

class M_FEAT_TBL_CACHE 

inherit

	CACHE [MELTED_FEATURE_TABLE]

creation

	make
	
feature 

	Cache_size: INTEGER is 20;
			-- Size of cache

end 
