-- Abstract description of a call as an instruction

class INSTR_CALL_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	call: CALL_AS;
			-- Call instruction

feature -- Initialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
		ensure then
			call_exists: call /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a call as an instruction
		local
			vkcn1: VKCN1;
		do
				-- Init type stack
			context.begin_expression;
			call.type_check;
				-- Check it is a procedure call
			if not context.item.conform_to (Void_type) then
					-- Error
				!!vkcn1;
				context.init_error (vkcn1);
				Error_handler.insert_error (vkcn1);
			end;
				-- Update the type stack
			context.pop (1);
		end;

	byte_node: INSTR_CALL_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_call (call.byte_node);
		end;


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			call.format (ctxt);
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			call.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
			Result.set_call (call.replicate (ctxt));
		end;

feature {INSTR_CALL_AS} -- Replication

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c;
		end;

end
