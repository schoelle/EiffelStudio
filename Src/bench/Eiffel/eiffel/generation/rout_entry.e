-- Representation for an routine entry in an instance of ROUT_TABLE

class ROUT_ENTRY

inherit

	ENTRY;
	SHARED_ID_TABLES;
	SHARED_EXEC_TABLE;
	SHARED_USED_TABLE;
	SHARED_ENCODER;

feature

	body_index: INTEGER;
			-- Body index

	written_type_id: INTEGER;
			-- Type id where the feature is written in

	pattern_id: INTEGER;
			-- Pattern id of the entry

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_written_type_id (i: INTEGER) is
			-- Assign `i' to `written_type_id'.
		do
			written_type_id := i
		end;

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end;

	body_id: INTEGER is
			-- Body id of the feature
		do
			Result := Body_index_table.item (body_index);
		end;

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
		do
			remover := System.remover;
			Result := 	remover = Void						-- Workbench mode
						or else
						remover.used_table.has (body_id)	-- Final mode
		end;

	routine_name: STRING is
			-- Routine name to generate
		do
			Result := Encoder.feature_name
				(System.class_type_of_id (written_type_id).id, body_id);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		local
			creation_type: CL_TYPE_I;
		do
				-- Dynamic type
			ba.append_short_integer (type_id - 1);
				-- Real body index
			ba.append_short_integer (real_body_index);
				-- Pattern id
			ba.append_short_integer (pattern_id);
		end;

	generate_workbench_info (file: UNIX_FILE) is
			-- Generate call info
		do
			file.putstring ("{(int16) ");
			file.putint (real_body_index);
			file.putstring (", (int16) ");
			file.putint (pattern_id);
			file.putchar ('}');
		end;

	generate_empty_info (file: UNIX_FILE) is
			-- Generate empty workbench info
		do
			file.putstring ("{(int16) 0, (int16) 0}");
		end;


	real_body_index: INTEGER is
			-- Real body index
		do
			Result := Dispatch_table.real_body_index
									(body_index, written_type_id) - 1;
		end;

end
