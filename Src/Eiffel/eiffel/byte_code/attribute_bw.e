note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarge node for attribute access in workbench mode

class ATTRIBUTE_BW

inherit

	ATTRIBUTE_BL
		redefine
			analyze_on,
			check_dt_current,
			free_register,
			generate_access_on_type,
			generate_separate_call,
			is_polymorphic,
			unanalyze
		end

create
	fill_from

feature -- C code generation

	analyze_on (reg: REGISTRABLE)
			-- <Precursor>
		do
			Precursor (reg)
			if context_type.is_separate then
					-- The register is used to store result of a separate feature call.
				result_register := context.get_argument_register (c_type)
			end
		end

	free_register
			-- <Precursor>
		do
			Precursor
			if result_register /= Void then
				result_register.free_register
			end
		end

	unanalyze
			-- <Precursor>
		do
			Precursor
			result_register := Void
		end

	check_dt_current (reg: REGISTRABLE)
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_A
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				class_type ?= context_type;
				if class_type /= Void then
					context.add_dt_current;
				end;
			end;
		end;

	is_polymorphic: BOOLEAN = True;
			-- Is the attribute access polymorphic ?

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate attribute access in a `typ' context
		local
			is_nested: BOOLEAN;
			type_i: TYPE_A;
			type_c: TYPE_C;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			is_nested := not is_first;
			type_i := real_type (type);
			type_c := type_i.c_type;
			if not type_i.is_true_expanded then
					-- For dereferencing, we need a star...
				buf.put_character ('*');
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (buf);
			end;
			buf.put_character ('(');
			reg.print_register;
			if reg.is_predefined or reg.register /= No_register then
				buf.put_three_character (' ', '+', ' ')
			else
				buf.put_two_character (' ', '+')
				buf.put_new_line;
				buf.indent;
			end;
			if is_nested then
				buf.put_string ("RTVA(");
			else
				buf.put_string ("RTWA(");
			end;
			buf.put_integer (routine_id)
			buf.put_string ({C_CONST}.comma_space);
			if is_nested then
				buf.put_string_literal (attribute_name)
				buf.put_string ({C_CONST}.comma_space);
				reg.print_register;
			else
				context.generate_current_dtype;
			end;
			buf.put_string ("))");
			if not (reg.is_predefined or reg.register /= No_register) then
			  buf.exdent;
			end;
		end;

feature {NONE} -- Separate call

	result_register: REGISTER
			-- A register to hold return value from a separate call.

	separate_attribute_macro: TUPLE [unqualified_call, qualified_call, creation_call: STRING]
			-- Name of a macro to make a call to a function depending on the kind of a call:
			-- See `routine_macro' for details.
		once
				-- There are no unqualified separate calls as well as creation function calls.
			Result := ["ERROR", "RTS_CF", "ERROR"]
		end

	generate_separate_call (s: REGISTER; r: detachable REGISTRABLE; t: REGISTRABLE)
			-- <Precursor>
		local
			buf: like buffer
		do
			check attached {CL_TYPE_A} context_type as c and attached r then
				buf := buffer
				buf.put_new_line
					-- Call to an attribute.
				generate_call_macro (separate_attribute_macro, t, c, s, result_register)
				buf.put_character (';')
				buf.put_new_line
				r.print_register
				buf.put_three_character (' ', '=', ' ')
				context.print_argument_register (result_register, buf)
				buf.put_character ('.')
				c_type.generate_typed_field (buf)
				buf.put_character (';')
			end
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
