indexing

	description:
		"Abstract description of an Eiffel function pointer. %
		%Version for Bench";
	date: "$Date$";
	revision: "$Revision$"

class ADDRESS_AS_B

inherit

	ADDRESS_AS
		redefine
			feature_name
		end;

	EXPR_AS_B
		undefine
			simple_format
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attribute

	feature_name: FEATURE_NAME_B;
			-- Feature name to address

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an address access.
		local
			internal_name: ID_AS_B;
			access_address: ACCESS_ADDRESS_AS_B;
			id_type: TYPE_A;
		do
				-- Initialization of the type stack
			context.begin_expression;

			internal_name := feature_name.internal_name;

			!!access_address.make (internal_name);
			id_type := access_address.access_type;

			if not context.access_line.access.is_feature then
				id_type := pointer_type;
			end;

				-- Update the type stack
			context.replace (id_type);
		end;

	byte_node: EXPR_B is
			-- Associated byte code.
		local
			access_line: ACCESS_LINE;
			access: ACCESS_B;
			address: ADDRESS_B;
			hector: HECTOR_B;
			a_feature: FEATURE_I;
		do
			access_line := context.access_line;
			access := access_line.access;
			access_line.forth;

			if access.is_feature then
				a_feature :=
					context.feature_table.item(feature_name.internal_name);
				!!address;
				address.init (a_feature);
				Result := address;
			else
				!!hector.make (access);
				Result := hector;
			end;
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.prepare_for_feature (feature_name.internal_name, void);
			if ctxt.is_feature_visible then
				ctxt.put_text_item (ti_Dollar);
					-- Treat infix and prefix
				ctxt.put_current_feature; 	
				ctxt.commit;
			else
				ctxt.rollback;
			end;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			l.add (feature_name.internal_name);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := clone (Current);
			ctxt.adapt_name (feature_name.internal_name);
			Result.feature_name.set_name (ctxt.adapted_name);
		end;

end -- class ADDRESS_AS_B
