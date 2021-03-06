note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Abstract description of an entry in a routine table (instance of
-- POLY_TABLE)

deferred class ENTRY

inherit
	COMPARABLE
		undefine
			is_equal
		end

	SHARED_WORKBENCH

	COMPILER_EXPORTER

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

feature -- comparison

	is_less alias "<" (other: ENTRY): BOOLEAN
			-- Is `other' greater than Current?
		do
			Result := type_id < other.type_id
		end

feature -- from ENTRY

	type_id: INTEGER
			-- Type id of the entry

	type: TYPE_A
			-- Result type fo the entry

	set_type_id (i: INTEGER)
			-- Assign `i' to `type_id'.
		do
			type_id := i;
		end;

	set_type (t: TYPE_A)
			-- Assign `t' to `type'.
		do
			type := t;
		end;

feature -- for dead code removal

	is_attribute: BOOLEAN
			-- is the feature_i associated an attribute ?
		do
		end

	is_deferred: BOOLEAN
			-- Is the feature_i associated a deferred routine?
		do
		end

	feature_id: INTEGER
			-- feature id of the feature associated to the entry

	set_feature_id (i: INTEGER)
		do
			feature_id := i
		end

feature -- Previously in POLY_UNIT

	class_id: INTEGER
			-- Id of the class associated to the current_unit

	type_a: TYPE_A
			-- Result type of the polymorphic entry

	set_class_id (i: INTEGER)
			-- Assign `i' to `class_id'
		do
			class_id := i
		end

	set_type_a (t: TYPE_A)
			-- Assign `t' to `type_a'.
		do
			type_a := t
		end

feature -- previously in POLY_UNIT

	entry (class_type: CLASS_TYPE; a_alias: BOOLEAN): ENTRY
			-- Entry in a poly-table for final mode
		require
			class_type_not_void: class_type /= Void
		deferred
		end;

	feature_type (class_type: CLASS_TYPE): TYPE_A
			-- Type id of the result type in `class_type'.
		require
			good_argument: class_type /= Void
		do
			Result := type_a
			if Result.is_like_current then
					-- We need to instantiate `like Current' in the context of `class_type'
					-- to fix eweasel test#exec035.
					-- Associated actual type is always attached.
				Result := Result.instantiated_in (class_type.type.as_attached_in (class_type.associated_class))
			end
		end

feature -- updates

	update (class_type: CLASS_TYPE)
			-- Enlarged current entry to manage correctly polymorphism with generics.
		require
			class_type_not_void: class_type /= Void
		do
			set_type_id (class_type.type_id)
			set_type (feature_type (class_type))
		end

feature -- from ENTRY

	used: BOOLEAN
			-- Is the entry used ?
		deferred
		end;

	static_feature_type_id: INTEGER
			-- Type id of the Result type
		local
			l_context_type: CL_TYPE_A
		do
			l_context_type := system.class_type_of_id (type_id).type
			if type.has_associated_class_type (l_context_type) then
				Result := type.static_type_id (l_context_type)
			end
		end

	generated_static_feature_type_id (buffer: GENERATION_BUFFER)
			-- Textual representation of type id of the Result type
		do
			buffer.put_static_type_id (static_feature_type_id)
		end;

	feature_type_id: INTEGER
			-- Type id of the Result type
		local
			l_context_type: CL_TYPE_A
		do
			l_context_type := system.class_type_of_id (type_id).type
			if type.has_associated_class_type (l_context_type) then
				Result := type.type_id (l_context_type)
			end
		end

	needs_extended_info: BOOLEAN
			-- Is `type' a type which needs more data to be resolved at run-time?
			--| Currently it is only generics, formals, anchors and types which are attached.
			--| We exclude expanded types since they are by default attached and thus only have
			--| one type at runtime.
		do
			Result := type.has_generics or else not type.is_explicit or else
				(not type.is_expanded and then type.is_attached)
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode: BOOLEAN)
			-- Generate list of type id's of generic type
			-- separated by commas.
		require
			is_generic : needs_extended_info
		do
			type.generate_cid (buffer, final_mode, False, system.class_type_of_id (type_id).type)
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY)
			-- Make byte code for type of current entry.
		require
			is_generic : needs_extended_info
		local
			t: CLASS_TYPE
		do
			t := system.class_type_of_id (type_id)
			if not attached context.context_class_type as ct then
				context.init (t)
				type.make_type_byte_code (ba, False, t.type)
			elseif ct.type_id /= t.type_id then
				context.change_class_type_context (t, t.type, t, t.type)
				type.make_type_byte_code (ba, False, t.type)
				context.restore_class_type_context
			else
				type.make_type_byte_code (ba, False, t.type)
			end
		end

feature -- Status report

	is_initialization_required: BOOLEAN
			-- Is initialization of an attribute required?
		deferred
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
