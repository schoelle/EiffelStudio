indexing
	description: "Abstract class for access: Current, Result, local, argument, feature"
	date: "$Date$"
	revision: "$Revision$"

deferred class ACCESS_B

inherit
	CALL_B
		redefine
			free_register, print_register,
			has_gcable_variable, propagate, generate, unanalyze,
			optimized_byte_node, inlined_byte_code,
			generate_il
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Access

	parameters: BYTE_LIST [PARAMETER_B] is
		do
			-- no parameters
		end

	target: ACCESS_B is
			-- Ourselves as part of a message applied to a target
		do
			Result := Current
		end

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		local
			a_parent: NESTED_B
		do
			if parent = Void then
				Result := context.current_type
			elseif is_message then
				Result := parent.target.type
			else
				a_parent := parent.parent
				if a_parent = Void then
					Result := context.current_type
				else
					Result := a_parent.target.type
				end
			end
			Result := Context.real_type (Result)
		end

	sub_enlarged (p: NESTED_BL): ACCESS_B is
			-- Enlarge node and set parent to `p'
		do
			Result := enlarged
			Result.set_parent (p)
		end

feature -- Status

	read_only: BOOLEAN is
			-- Is the access a read-only one ?
		do
			Result := True
		end

	current_needed_for_access: BOOLEAN is
			-- Is current needed for a true access ?
		do
			Result := is_predefined implies is_current
		end

	has_gcable_variable: BOOLEAN is
			-- Is the access using a GCable variable ?
		local
			expr_b: EXPR_B
			is_in_register: BOOLEAN
			i, nb: INTEGER
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
		do
			is_in_register := register /= Void and register /= No_register
			if is_in_register and register.c_type.is_pointer then
					-- Access is stored in a pointer register
				Result := True
			else
				if parent = Void or else parent.target.is_current then
						-- True access: we may need Current.
					Result := (current_needed_for_access and not is_in_register)
						or (is_result and c_type.is_pointer)
				end
					-- Check the parameters if needed, i.e. if there are
					-- any and if the access is not already stored in a
					-- register (which can't be a pointer, otherwise it would
					-- have been handled by the first "if").
				l_parameters := parameters
				if not is_in_register and l_parameters /= Void then
					from
						l_area := l_parameters.area
						nb := l_parameters.count
					until
						i = nb or Result
					loop
						expr_b := l_area.item (i)
						Result := expr_b.has_gcable_variable
						i := i + 1
					end
				end
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			l_parameters: BYTE_LIST [EXPR_B]
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb or Result
				loop
					expr := l_area.item (i)
					Result := expr.used(r)
					i := i + 1
				end
			end
		end

	is_single: BOOLEAN is
			-- Is access a single one ?
		local
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			l_parameters: BYTE_LIST [EXPR_B]
			expr_b: EXPR_B
		do
				-- If it is predefined, then it is single.
			Result := is_predefined
			if not Result then
				Result := True
					-- It is not predefined. If it has parameters, then none
					-- of them may have a call or allocate memory (manifest arrays,
					-- strings, ...).
				l_parameters := parameters
				if l_parameters /= Void then
					from
						l_area := l_parameters.area
						nb := l_parameters.count
					until
						i = nb or not Result
					loop
						expr_b := l_area.item (i)
						Result := not expr_b.allocates_memory and not expr_b.has_call
						i := i + 1
					end
				end
			end
		end

	is_polymorphic: BOOLEAN is
			-- Is the access polymorphic ?
		do
			Result := False
		end

feature -- Element change

	propagate (r: REGISTRABLE) is
			-- Propagate register across access
		do
			if (register = Void) and not context_type.is_basic then
				if 	(real_type (type).c_type.same_class_type (r.c_type)
					or
					(	r = No_register
						and
						(	(parent = Void or else parent.target.is_current)
							or parameters = Void))
					)
					and
					(r = No_register implies context.propagate_no_register)
				then
					set_register (r)
					context.set_propagated
				end
			end
		end

feature -- Setting

	set_parameters (p: like parameters) is
		do
			-- Do nothing
		end

feature -- C generation

	print_register is
			-- Print register or generate if there are no register.
		do
			if register /= No_register then
				Precursor {CALL_B}
			else
				generate_access
			end
		end

	free_register is
			-- Free register used by last call expression. If No_register was
			-- propagated, also frees the registers used by target and
			-- last message.
		do
			Precursor {CALL_B}
				-- Free those registers which where kept because No_register
				-- was propagated, hence call was meant to be expanded in-line.
			if perused then
				free_param_registers
			end
		end

	perused: BOOLEAN is
			-- See if the expression we are computing is going to be expanded
			-- on-line for later perusal: for instance, when computing the
			-- expression f(g(y), h(x)), the register used by the parameters
			-- must NOT be freed if the call is expanded, i.e. if register is
			-- No_register for f() as soon as the call is analyzed. If f() is
			-- indeed part of the parameters of another function, it would be
			-- a disaster...
		do
			Result := register = No_register or else
				(parent /= Void and then parent.register = No_register)
		end

	unanalyze_parameters is
			-- Undo the analysis on parameters
		local
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			expr_b: EXPR_B
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb
				loop
					expr_b := l_area.item (i)
					expr_b.unanalyze
					i := i + 1
				end
			end
		end

	free_param_registers is
			-- Free registers used by parameters
		local
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			expr_b: EXPR_B
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb
				loop
					expr_b := l_area.item (i)
					expr_b.free_register
					i := i + 1
				end
			end
		end

	unanalyze is
			-- Undo the analysis
		do
			set_register (Void)
			unanalyze_parameters
		end

	Current_register: REGISTRABLE is
			-- The "Current" entity
		do
			Result := Context.Current_register
		end

	analyze_on (reg: REGISTRABLE) is
			-- Analyze access on `reg'
		do
				-- This will be redefined where needed. By default, run
				-- a simple analyze and forget about the parameter.
			analyze
		end

	generate is
			-- Generate C code for the access.
		local
			buf: GENERATION_BUFFER
		do
			generate_parameters (current_register)
			if register /= No_register then
				buf := buffer
						-- Procedures have a void return type
				if register /= Void then
					register.print_register
					buf.put_string (" = ")
				end
				generate_access
				buf.put_character (';')
				buf.put_new_line
			end
		end

	generate_on (reg: REGISTRABLE) is
			-- Generate access using `reg' as "Current"
		do
		end

	generate_access is
			-- Generation of the C code for access
		do
		end

	generate_parameters (reg: REGISTRABLE) is
			-- Generate code for parameters computation.
			-- `reg' ("Current") is not used except for
			-- inlining
		require
			reg_not_void: reg /= Void
		do
			if parameters /= Void then
				parameters.generate
			end
		end

feature -- Conveniences

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		deferred
		end

	is_assignable: BOOLEAN is
			-- Can current be assigned to?
		do
			Result := is_local or is_current or is_attribute or is_result
		end

	is_message: BOOLEAN is
			-- is the access a message ?
		require
			parent_exists: parent /= Void
		do
			Result := parent.message.canonical = Current
		end

	is_attribute: BOOLEAN is
			-- Is Current an access to an attribute ?
		do
		end

	is_feature: BOOLEAN is
			-- Is Current an access to an Eiffel feature ?
		do
		end

	is_creatable: BOOLEAN is
			-- Can the access be a target of a creation ?
		do
		end

	is_first: BOOLEAN is
			-- Is the access the first one in a multi-dot expression ?
		local
			p: like parent
			p_target: ACCESS_B
			constant_b: CONSTANT_B
		do
			p := parent
			if p = Void then
				Result := True
			else
				p_target := p.target
				if (p_target = Current and then p.parent = Void) then
					Result := True
				else
						-- Bug fix: CONSTANT_B has a special construct
						-- for nested calls
					constant_b ?= p_target
					Result := constant_b /= Void and then
						constant_b.access = Current and then p.parent = Void
				end
			end
		end

feature -- Code generation

	argument_types: ARRAY [STRING] is
			-- Array of C types for the arguments
		local
			p: like parameters
			i, j, nb: INTEGER
			expr: EXPR_B
			param: PARAMETER_B
			type_c: TYPE_C
		do
			p := parameters
			if p = Void then
				Result := <<"EIF_REFERENCE">>
			else
				from
					i := 1
					nb := p.count
					create Result.make (1, nb + 1)
					Result.put ("EIF_REFERENCE", 1)
					j := 2
				until
					i > nb
				loop
					expr := p @ i
					param ?= expr
						-- FIXME
					if param = Void then
						type_c := real_type (expr.type).c_type
					else
						type_c := real_type (param.attachment_type).c_type
					end
					Result.put (type_c.c_string, j)

					i := i +1
					j := j +1
				end
			end
		end

feature -- IL code generation

	generate_il_call_access (is_target_of_call: BOOLEAN) is
			-- Generate `Current' which `is_predefined'.
			-- If `is_target_of_call' we might need to do some
			-- special transformation if Current type is expanded.
		require
			il_generation: System.il_generation
		local
			type_i: TYPE_I
		do
				-- Mutual recursive call in ACCESS_B, but
				-- `is_predefined' descendants will stop
				-- recursion when it occurs because current
				-- feature is redefined.
			generate_il_value
			if is_target_of_call then
				type_i := real_type (type)
				if type_i.is_true_expanded and then not type_i.type_a.associated_class.is_enum then
						-- Pointer to value type is required
					generate_il_metamorphose (type_i, type_i, True)
				end
			end
		end

	generate_il is
			-- Generate IL for Current.
		do
				-- Mutual recursive call in ACCESS_B, but
				-- not `is_predefined' descendants will stop
				-- recursion when it occurs because current
				-- feature is redefined.
			generate_il_call_access (False)
		end

	need_address (is_target_of_call: BOOLEAN): BOOLEAN is
			-- Does current access need its address loaded in memory?
		local
			cl_type: CL_TYPE_I
			call_access: CALL_ACCESS_B
			l_nested: NESTED_B
			l_constant: CONSTANT_B
			l_ext: EXTERNAL_B
			l_il_ext: IL_EXTENSION_I
		do
			cl_type ?= real_type (type)
			Result := is_target_of_call and then cl_type.is_true_expanded

			if Result then
				call_access ?= parent.message

				if call_access = Void then
						-- Find out if it is a nested call.
					l_nested ?= parent.message

					if l_nested = Void then
						l_constant ?= parent.message
						check
								-- It has to be a constant access, as otherwise
								-- it means the original code was not Eiffel code.
							l_constant_not_void: l_constant /= Void
						end
						call_access ?= l_constant.access
					else
						call_access ?= l_nested.target
					end
				end

					-- We do not load the address if it is an optimized call of the compiler.
				Result := not call_access.is_il_feature_special (cl_type)
				if Result then
					l_ext ?= call_access
					if l_ext /= Void then
						l_il_ext ?= l_ext.extension
						Result := l_il_ext = Void or else l_il_ext.type /=
							{SHARED_IL_CONSTANTS}.Operator_type
					end
				end
			end
		end

	generate_il_address is
			-- Generate address of current if it makes sense, otherwise
			-- do nothing.
		require
			is_first: is_first
		do
		end

	generate_il_start_assignment is
			-- Generate location of assignment if needed.
		do
			if is_attribute then
				il_generator.generate_current
			end
		end

	frozen generate_il_assignment (source_type: TYPE_I)  is
			-- Generate source assignment IL code.
		require
			is_creatable: is_creatable
			source_type_not_void: source_type /= Void
		local
			target_type: TYPE_I
		do
			target_type := Context.real_type (type)
			generate_il_simple_assignment (target_type, source_type)
		end

	frozen generate_il_reverse_assignment (source_type: TYPE_I) is
			-- Generate reverse assignment IL code.
		require
			is_creatable: is_creatable
			source_type_not_void: source_type /= Void
		local
			target_type: TYPE_I
		do
			target_type := Context.real_type (type)
			generate_il_simple_assignment (target_type, source_type)
		end

feature {NONE} -- Il code generation

	frozen generate_il_simple_assignment (target_type, source_type: TYPE_I) is
			-- Generate simple source assignment
		require
			is_creatable: is_creatable
			target_type_not_void: target_type /= Void
			source_type_not_void: source_type /= Void
		local
			attr: ATTRIBUTE_B
			loc: LOCAL_B
			res: RESULT_B
			cl_type: CL_TYPE_I
		do
					-- Generate cast if we have to generate verifiable code
					-- since access might have been redefined and in this
					-- case its type for IL generation is the one from the
					-- parent not the redefined one. Doing the cast enable
					-- the verifier to find out that what we are doing is
					-- correct. Cast is not needed for expanded type since
					-- they cannot be redefined.
			if
				System.il_verifiable and then not target_type.is_expanded
				and then not target_type.is_none
			then
				il_generator.generate_check_cast (source_type, target_type)
			end

			if is_attribute then
				attr ?= Current
				cl_type ?= attr.context_type
				if cl_type.is_expanded then
						-- Generate direct assignment.
					il_generator.generate_attribute_assignment (attr.need_target,
						cl_type, cl_type.base_class.feature_of_rout_id (attr.routine_id).feature_id)
				else
						-- Generate assignment to the potentially inherited attribute.
					il_generator.generate_attribute_assignment (attr.need_target,
						il_generator.implemented_type (attr.written_in, cl_type), attr.attribute_id)
				end
			elseif is_local then
				loc ?= Current
				il_generator.generate_local_assignment (loc.position)
			elseif is_result then
				res ?= Current
				il_generator.generate_result_assignment
			end
		end

feature -- Byte code generation

	bit_assign_code: CHARACTER is
			-- Bits assignment byte code
			-- (By default it is the assign_code)
		do
			Result := assign_code
		end

	assign_code: CHARACTER is
			-- Simple assignment byte code
		do
			-- Do nothing
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment byte code
		do
			-- Do nothing
		end

	reverse_code: CHARACTER is
			-- Reverse assignment byte code	
		do
			-- Do nothing
		end

feature -- Array optimization

	optimized_byte_node: like Current is
			-- Redefined for type check
		do
			Result := Current
		end

	conforms_to_array_opt: BOOLEAN is
		do
			Result := (is_argument or else is_local or else is_result)
				and then type.conforms_to_array
		end

	array_descriptor: INTEGER is
			-- Array description
			-- argument:<0; Result:0; local:>0
		do
		end

feature -- Inlining

	inlined_byte_code: ACCESS_B is
			-- Redefined for type check
		do
			Result := Current
		end

end
