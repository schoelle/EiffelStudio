indexing
	description: "Provide reflection mechanisms to inspect EAC"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_REFLECTION

inherit
	CACHE_READER
		redefine
			consumed_type,
			assembly_types
		end

create {EMITTER}
	make

feature -- Redefined

	consumed_type (t: TYPE): CONSUMED_TYPE is
			-- Consumed type corresponding to `t'.
		do
			Types_cache.search (t.full_name)
			if types_cache.found then
				Result := types_cache.found_item
			else
				Result := Precursor {CACHE_READER} (t)
				if Result /= Void then
					types_cache.put (Result, t.full_name)
				end
			end
		end

	assembly_types (a_assembly: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_TYPES is
			-- Assembly information from EAC
		do
			assembly_types_cache.search (a_assembly.gac_path)
			if assembly_types_cache.found then
				Result := assembly_types_cache.found_item
			else
				Result := Precursor {CACHE_READER} (a_assembly)
				if Result /= Void then
					assembly_types_cache.put (Result, a_assembly.gac_path)
				end
			end
		end

feature -- Initialization

	initialize_cache (a_path: STRING) is
			-- initialize cache with a binary file containing
			-- specifics consumed types.
		require
			non_void_path: a_path /= Void
			not_empty_path: not a_path.is_empty
		local
			l_raw_file: RAW_FILE
			l_consumed_types: LINKED_LIST [CONSUMED_TYPE]
		do
			if feature {SYSTEM_FILE}.exists (a_path.to_cil) then
				create l_raw_file.make (a_path)
				l_raw_file.open_read
				l_consumed_types ?= l_raw_file.retrieved
				if l_consumed_types /= Void then
					from
						l_consumed_types.start
					until
						l_consumed_types.after
					loop
						Types_cache.search (l_consumed_types.item.dotnet_name)
						if not Types_cache.found then
							Types_cache.put (l_consumed_types.item, l_consumed_types.item.dotnet_name)
						end
						l_consumed_types.forth
					end
				end
			end
		end

feature -- Access

	type_name (t: TYPE): STRING is
			-- Eiffel name of .NET type `t'.
		local
			ct: CONSUMED_TYPE
		do
			if is_type_in_cache (t) then
				ct := consumed_type (t)
				if ct /= Void then
					Result := ct.eiffel_name.twin
				end				
			end
		end	

	feature_name (t: TYPE; dotnet_name: STRING; args: NATIVE_ARRAY [TYPE]): STRING is
			-- Eiffel name of .NET function `dotnet_name' from type `t' with arguments `args'.
		require
			non_void_type: t /= Void
			non_void_name: dotnet_name /= Void
			valid_name: not dotnet_name.is_empty
			valid_args: args /= Void implies args.count >= 0
		local
			ct: CONSUMED_TYPE
			crt: CONSUMED_REFERENCED_TYPE
			fields: ARRAY [CONSUMED_FIELD] 
			procedures: ARRAY [CONSUMED_PROCEDURE]
			functions: ARRAY [CONSUMED_FUNCTION]
			constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			found: BOOLEAN
			i, j, count: INTEGER
			ca: CONSUMED_ASSEMBLY
			cargs: ARRAY [CONSUMED_ARGUMENT]
			am: ARRAY [CONSUMED_ASSEMBLY]
		do
			if is_type_in_cache (t) then
				ct := consumed_type (t)
			end
			ca := consumed_assembly_from_path (t.assembly.location)
			if ca /= Void then
				am := assembly_mapping_array (ca)
			end
			if ct /= Void and am /= Void then
				if dotnet_name.is_equal (Constructor_name) then
					constructors := ct.constructors
					if constructors /= Void then
						from
							i := 1
							count := constructors.count
						until
							i > count or found
						loop
							cargs := constructors.item (i).arguments
							if cargs.count = args.count then
								from
									j := 1
									found := True
								until
									j > cargs.count or not found
								loop
									crt := cargs.item (j).type
									found := crt.name.to_cil.equals (args.item (j - 1).full_name) and then
										am.item (crt.assembly_id).is_equal (consumed_assembly_from_path (args.item (j - 1).assembly.location))
									j := j + 1
								end
							end
							if found then
								Result := constructors.item (i).eiffel_name
							end
							i := i + 1
						end
					end
				elseif args /= Void then
					functions := ct.functions
					if functions /= Void then
						from
							i := 1
						until
							i > functions.count or found
						loop
							if functions.item (i).dotnet_name.is_equal (dotnet_name) then
								cargs := functions.item (i).arguments
								if cargs.count = args.count then
									from
										j := 1
										found := True
									until
										j > cargs.count or not found									
									loop
										crt := cargs.item (j).type
										found := crt.name.to_cil.equals (args.item (j - 1).full_name) and then
											am.item (crt.assembly_id).is_equal (consumed_assembly_from_path (args.item (j - 1).assembly.location))
										j := j + 1
									end
								end
							end
							if found then
								Result := functions.item (i).eiffel_name
							end
							i := i + 1
						end
					end
					if not found then
						procedures := ct.procedures
						if procedures /= Void then
							from
								i := 1
							until
								i > procedures.count or found
							loop
								if procedures.item (i).dotnet_name.is_equal (dotnet_name) then
									cargs := procedures.item (i).arguments
									if cargs.count = args.count then
										from
											j := 1
											found := True
										until
											j > cargs.count or not found
										loop
											crt := cargs.item (j).type
											found := crt.name.to_cil.equals (args.item (j - 1).full_name) and then
												am.item (crt.assembly_id).is_equal (consumed_assembly_from_path (args.item (j - 1).assembly.location))
											j := j + 1
										end
									end
								end
								if found then
									Result := procedures.item (i).eiffel_name
								end
								i := i + 1
							end
						end
					end
				else
					-- No arguments, search fields first
					fields := ct.fields
					if fields /= Void then
						from
							i := 1
						until
							i > fields.count or found
						loop
							found := fields.item (i).dotnet_name.is_equal (dotnet_name)
							if found then
								Result := fields.item (i).eiffel_name
							end
							i := i + 1
						end						
					end
					if not found then
						functions := ct.functions
						if functions /= Void then
							from
								i := 1
							until
								i > functions.count or found
							loop
								found := functions.item (i).dotnet_name.is_equal (dotnet_name)
								if found then
									Result := functions.item (i).eiffel_name
								end
								i := i + 1
							end
						end
					end
					if not found then
						procedures := ct.procedures
						if procedures /= Void then
							from
								i := 1
							until
								i > procedures.count or found
							loop
								found := procedures.item (i).dotnet_name.is_equal (dotnet_name)
								if found then
									Result := procedures.item (i).eiffel_name
								end
								i := i + 1
							end
						end
					end
				end
			end
		end

 	assembly_mapping_array (a_assembly: CONSUMED_ASSEMBLY): ARRAY [CONSUMED_ASSEMBLY] is
 			-- Assembly mapping for assembly `a_assembly'.
 		require
 			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
 		do
			assemblies_mappings_cache.search (a_assembly.gac_path)
			if assemblies_mappings_cache.found then
				Result := assemblies_mappings_cache.found_item
			else
				Result := assembly_mapping_from_consumed_assembly (a_assembly).assemblies
				assemblies_mappings_cache.put (Result, a_assembly.gac_path)
			end
  		end

	entity (entities_list: LIST [CONSUMED_ENTITY]; args: NATIVE_ARRAY [TYPE]): CONSUMED_ENTITY is
			-- return `consumed_entity' corresponding to parameters.
			-- `entities_list' is given by `entities'.
		require
			valid_entities: entities_list /= Void
			valid_args: args /= Void implies args.count >= 0
		local
			cargs: ARRAY [CONSUMED_ARGUMENT]
			crt: CONSUMED_REFERENCED_TYPE
			found: BOOLEAN
			i: INTEGER
--			am: ARRAY [CONSUMED_ASSEMBLY]
		do
--			am := assembly_mapping_array (consumed_assembly_from_path (t.assembly.location))
			from
				entities_list.start
			until
				entities_list.after or Result /= Void
			loop
				cargs := entities_list.item.arguments
				if cargs.count = args.count then
					-- compare arguments
					from
						i := 1
						found := True
					until
						i > cargs.count or not found									
					loop
						crt := cargs.item (i).type
						found := crt.name.to_cil.equals (args.item (i - 1).full_name) 
--							and then am.item (crt.assembly_id).is_equal (consumed_assembly_from_path (args.item (i - 1).assembly.location))
						i := i + 1
					end
					if found then
						Result := entities_list.item
					end
				end

				entities_list.forth
			end
		end

	entities (t: TYPE; dotnet_feature_name: STRING): LIST [CONSUMED_ENTITY] is
			-- Return list of Eiffel Eiffel entities associated to `dotnet_feature_name'.
		require
			non_void_t: t /= Void
			non_void_dotnet_feature_name: dotnet_feature_name /= Void
			not_empty_dotnet_feature_name: not dotnet_feature_name.is_empty
		local
			ct: CONSUMED_TYPE
			fields: ARRAY [CONSUMED_FIELD] 
			procedures: ARRAY [CONSUMED_PROCEDURE]
			functions: ARRAY [CONSUMED_FUNCTION]
			constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			i: INTEGER
		do
			create {ARRAYED_LIST [CONSUMED_ENTITY]} Result.make (24)

			Types_cache.search (t.full_name)
			if Types_cache.found then
				ct := types_cache.found_item
			else
				ct := consumed_type (t)
				if ct /= Void then
					types_cache.put (ct, t.full_name)
				end
			end
			if ct /= Void then
				if dotnet_feature_name.is_equal (Constructor_name) then
					constructors := ct.constructors
					if constructors /= Void then
						from
							i := 1
						until
							i > constructors.count
						loop
							Result.extend (constructors.item (i))
							i := i + 1
						end
					end
				else
					functions := ct.functions
					if functions /= Void then
						from
							i := 1
						until
							i > functions.count
						loop
							if functions.item (i).dotnet_name.is_equal (dotnet_feature_name) then
								Result.extend (functions.item (i))
							end
							i := i + 1
						end
					end

					procedures := ct.procedures
					if procedures /= Void then
						from
							i := 1
						until
							i > procedures.count
						loop
							if procedures.item (i).dotnet_name.is_equal (dotnet_feature_name) then
								Result.extend (procedures.item (i))
							end
							i := i + 1
						end
					end

					fields := ct.fields
					if fields /= Void then
						from
							i := 1
						until
							i > fields.count
						loop
							if fields.item (i).dotnet_name.is_equal (dotnet_feature_name) then
								Result.extend (fields.item (i))
							end
							i := i + 1
						end						
					end
				end
			end
		ensure
			non_void_feature_names: Result /= Void
		end

feature -- Implementation

	Types_cache: CACHE [CONSUMED_TYPE, STRING] is
			-- Cache for loaded types
		once
			create Result.make (Max_cache_items)
		end

	Assembly_types_cache: CACHE [CONSUMED_ASSEMBLY_TYPES, STRING] is
			-- Cache of assembly types
		once
			create Result.make (15)
		end

feature {NONE} -- Implementation

	Constructor_name: STRING is ".ctor"

	assemblies_mappings_cache: CACHE [ARRAY [CONSUMED_ASSEMBLY], STRING] is
			-- Cache for assemblies ids mappings
		once
			create Result.make (Max_cache_items)
		end

	Max_cache_items: INTEGER is 40
			-- Maximum number of types stored in local cache

end -- class CACHE_REFLECTION
