-- A binary operation.

deferred class BINARY_B 

inherit

	EXPR_B
		redefine
			propagate, print_register,
			analyze, unanalyze, generate, enlarged,
			free_register, has_gcable_variable,
			has_call, make_byte_code
		end;
	
feature 

	left: EXPR_B;
			-- Left expression operand

	right: EXPR_B;
			-- Right expression operand

	access: FEATURE_B;
			-- Access when left is not a simple type

	type: TYPE_I is
			-- Type of the infixed feature
		do
			Result := access.type;
		end;

	set_left (l: EXPR_B) is
			-- Assign `l' to `left'.
		do
			left := l;
		end;

	set_right (r: EXPR_B) is
			-- Assign `r' to `right'.
		do
			right := r;
		end;

	set_access (a: FEATURE_B) is
			-- Set `access' to `a'
		do
			access := a;
		end;
			
	init (a: FEATURE_B) is
			-- Initializes node
		do
			access := a;
		end;

	is_commutative: BOOLEAN is
			-- Is the operation commutative ?
		do
		end;

	is_simple: BOOLEAN is
			-- Is the operation a simple one (C's point of view).
			-- Definition: An operation X is simple for C if it can be
			-- combined in affectation under the shortcut X=.
		do
		end;

	is_additive: BOOLEAN is
			-- Is the operation additive (i.e. + or -) ?
		do
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		deferred
		end;

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable ?
		do
			Result := left.has_gcable_variable or right.has_gcable_variable;
		end;

	has_call: BOOLEAN is
			-- Is the expression using a call ?
		do
			Result := left.has_call or right.has_call;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' used in the expression ?
		do
			Result := left.used (r) or right.used (r);
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					left.propagate (r);
				end;
				if not context.propagated or r = No_register then
					right.propagate (r);
				end;
			elseif not left.used (r) then
				if not context.propagated then
					right.propagate (r);
				end;
			elseif not right.used (r) then
				if not context.propagated then
					left.propagate (r);
				end;
			end;
		end;

	free_register is
			-- Free registers used by the expression
		do
			left.free_register;
			right.free_register;
		end;

	analyze is
			-- Analyze expression
		do
			left.analyze;
			right.analyze;
		end;
	
	unanalyze is
			-- Undo the previous analysis
		local
			void_register: REGISTER;
		do
			left.unanalyze;
			right.unanalyze;
			set_register (void_register);
		end;

	generate is
			-- Generate expression
		do
			left.generate;
			right.generate;
		end;

	generate_plus_plus is
			-- Generate things like ++ or --
		do
		end; -- generate_plus_plus

	generate_simple is
			-- Generate operator followed by assignment
		do
		end; -- generate_simple

	print_register is
			-- Print expression value
		do
			left.print_register;
			generate_operator;
			right.print_register;
		end;

	generate_operator is
			-- Generate operator in C
		do
		end;

	enlarged: EXPR_B is
			-- Enlarge the left and right handsides
		local
			nested_b: NESTED_B;
			a_access_expr: ACCESS_EXPR_B;
			param: BYTE_LIST [EXPR_B];
		do
			if not is_built_in then
					-- Change this node into a nested call
				!!nested_b;
				!!a_access_expr;
				a_access_expr.set_expr (left);
				a_access_expr.set_parent (nested_b);
				nested_b.set_target (a_access_expr);
				!!param.make (1);
				param.put_i_th (right, 1);
				access.set_parameters (param);
				access.set_parent (nested_b);
				nested_b.set_message (access);
				Result := nested_b.enlarged;
			else
					-- Enlarge current node
				left := left.enlarged;
				right := right.enlarged;
				access := access.enlarged;
				Result := Current;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for binary expression
		local
			param: BYTE_LIST [BYTE_NODE];
		do
			if is_built_in then
				make_standard_byte_code (ba);
			else
				make_call_byte_code (ba);
			end;
		end;
	
	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			right.make_byte_code (ba);
				-- Write binary operator
			ba.append (operator_constant);
		end;

	make_call_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an inxed call
		local
			param: BYTE_LIST [EXPR_B];
		do
				-- Production of a nested structure: target is
				-- an access expression (`left') and parameter
				-- of `access' is expression `right'.
			Nested.set_message (access);
			access.set_parent (Nested);
			Access_expr.set_expr (left);
			!!param.make (1);
			param.put_i_th (right, 1);
			access.set_parameters (param);
				-- Byte code generation on a nested call
			Nested.make_byte_code (ba);
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		deferred
		end;

	Nested: NESTED_B is
			-- Nested buffer for byte code generation of a binary
			-- operation on non-simple types
		once
			!!Result;
			Result.set_target (Access_expr);
			Access_expr.set_parent (Result);
		end;

	Access_expr: ACCESS_EXPR_B is
			-- Access on expression
		once
			!!Result;
		end;

end
