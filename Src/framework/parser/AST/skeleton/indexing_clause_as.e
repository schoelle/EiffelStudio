note
	description: "Representation of an indexing clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXING_CLAUSE_AS

inherit
	EIFFEL_LIST [INDEX_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_indexing_clause_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- First token in current AST node
		do
			if a_list = Void then
				Result := Precursor {EIFFEL_LIST} (a_list)
			else
				Result := indexing_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- Last token in current AST node
		do
			if a_list = Void then
				Result := Precursor {EIFFEL_LIST} (a_list)
			else
				Result := end_keyword (a_list)
				if Result = Void then
					if not is_empty then
						Result := Precursor (a_list)
					else
						Result := indexing_keyword (a_list)
					end
				end
			end
		end

feature -- Access

	custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Expression representing custom attributes.
		local
			l_list: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Attribute_header)
			end
		end

	class_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Expression representing custom attributes.
		local
			l_list: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Class_metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Class_attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Class_attribute_header)
			end
		end

	interface_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Expression representing custom attributes.
		local
			l_list: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Interface_metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Interface_attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Interface_attribute_header)
			end
		end

	assembly_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Expression representing custom attributes for an assembly
		local
			l_list: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			Result := internal_custom_attributes (Assembly_metadata_header)
			if Result /= Void then
				l_list := internal_custom_attributes (Assembly_attribute_header)
				if l_list /= Void then
					Result.append (l_list)
				end
			else
				Result := internal_custom_attributes (Assembly_attribute_header)
			end
		end

	property_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Expression representing custom attributes for a property
		do
			Result := internal_custom_attributes (Property_metadata_header)
		end

	has_global_once: BOOLEAN
			-- Is current once construct used to be a global once in
			-- multithreaded context?
		do
			Result := has_tag_value (once_status_header, global_value)
		end

	is_stable: BOOLEAN
			-- Is feature marked as stable?
			-- (Used to mark stable attributes.)
		do
			Result := has_tag_value (option_header, stable_option_value)
		end

	is_transient: BOOLEAN
			-- Is feature marked as transient?
			-- (Used to mark transient attributes, i.e. not stored on disk.)
		do
			Result := has_tag_value (option_header, transient_option_value)
		end

	is_hidden_in_debugger_call_stack: BOOLEAN
			-- Is feature marked as hidden from debugger?
		do
			Result := has_tag_value (debugger_header, is_hidden_in_debugger_call_stack_value)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	description: detachable STRING
			-- Description.
		do
			Result := string_value (Description_header)
		end

	assembly_name: detachable ARRAY [STRING_32]
			-- Assembly name (for external classes only)
			-- Name, Version, Culture and Public key in that order
		local
			i: detachable INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := index_as_of_tag_name (Assembly_header)

			if i /= Void then
				list := i.index_list
				from
					list.start
					create Result.make_filled ({STRING_32} "", 1, list.count)
				until
					list.after
				loop
					if attached {STRING_AS} list.item as l_string then
						Result.put (l_string.value_32, list.index)
					end
					list.forth
				end
			end
		end

	external_name: detachable STRING
			-- Name of entity holding current indexing clause as seen from
			-- external world.
		do
			Result := string_value (External_header)
		end

	property_name: detachable STRING
			-- Expression representing custom attributes for a property
		local
			i: detachable INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := index_as_of_tag_name (property_name_header)
			if i /= Void then
				list := i.index_list
				if not list.is_empty then
					if attached {STRING_AS} list.first as s then
							-- Explicit property name
						Result := s.value
					elseif attached {ID_AS} list.first as id and then id.name.as_lower.is_equal ("auto") then
							-- Implicit property name
						Result := ""
					end
				end
			end
		end

	dotnet_constructors: detachable ARRAYED_LIST [STRING]
			-- Dotnet constructors indexing clause value
		local
			l_index: detachable INDEX_AS
			l_list: EIFFEL_LIST [ATOMIC_AS]
		do
			l_index := index_as_of_tag_name (Dotnet_constructors_header)
			if l_index /= Void then
				l_list := l_index.index_list
				if not l_list.is_empty then
					create Result.make (l_list.count)
					from
						l_list.start
					until
						l_list.after
					loop
						if attached {STRING_AS} l_list.item as l_string then
							Result.extend (l_string.value)
						elseif attached {ID_AS} l_list.item as l_id then
							Result.extend (l_id.name)
						end
						l_list.forth
					end
					Result.compare_objects
				end
			end
		end

	enum_type: detachable STRING
			-- Is current once construct used to be a global once in
			-- multithreaded context?
		local
			i: detachable INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := index_as_of_tag_name (Enum_type_header)

			if i /= Void then
				list := i.index_list
				if not list.is_empty then
					from
						list.start
					until
						list.after or Result /= Void
					loop
						if attached {STRING_AS} list.item as s then
							Result := s.value
						end
						list.forth
					end
				end
			end
		end

feature -- Query

	storable_version: detachable STRING
			-- Description.
		do
			Result := string_value (storable_version_header)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Query

	index_as_of_tag_name (tag: READABLE_STRING_GENERAL): detachable INDEX_AS
			-- Find INDEX_AS object holding `tag'
			-- Void if not found.
		require
			tag_not_void: tag /= Void
			tag_not_empty: not tag.is_empty
		local
			i, nb: INTEGER
			l_index: INDEX_AS
		do
			from
				i := lower
				nb := upper
			until
				i > nb
			loop
				l_index := i_th (i)
				if attached l_index.tag as l_tag and then l_tag.name.same_caseless_characters_general (tag, 1, tag.count, 1) then
					Result := l_index
						-- Jump out of loop
					i := nb
				end
				i := i + 1
			end
		ensure
			found_return_same_object: Result /= Void implies Result = index_as_of_tag_name (tag)
		end

	once_status_index_as: detachable INDEX_AS
			-- Index of the once_status header (if any)
		do
			Result := index_as_of_tag_name (once_status_header)
		end

feature {NONE} -- Constants

	External_header: STRING = "external_name"
			-- Index name which holds name as seen by other languages.

	Metadata_header: STRING = "metadata"
			-- Index name which holds custom attributes applied to both implementation
			-- and interface of current class.

	Class_metadata_header: STRING = "class_metadata"
			-- Index name which holds custom attributes applied to associated class only.

	Interface_metadata_header: STRING = "interface_metadata"
			-- Index name which holds custom attributes applied to associated interface only.

	Assembly_metadata_header: STRING = "assembly_metadata"
			-- Index name which holds custom attributes applied to associated assembly.
			-- They are only taken into account for the root_class.

	Property_metadata_header: STRING = "property_metadata"
			-- Index name which holds custom attributes applied to associated property.

	Attribute_header: STRING = "attribute"
			-- Index name which holds custom attributes applied to both implementation
			-- and interface of current class.

	Class_attribute_header: STRING = "class_attribute"
			-- Index name which holds custom attributes applied to associated class only.

	Interface_attribute_header: STRING = "interface_attribute"
			-- Index name which holds custom attributes applied to associated interface only.

	Assembly_attribute_header: STRING = "assembly_attribute"
			-- Index name which holds custom attributes applied to associated assembly.
			-- They are only taken into account for the root_class.

	Dotnet_constructors_header: STRING = "dotnet_constructors"
			-- Index name which holds list of creation routines to be used as type constructors.

	Description_header: STRING = "description"
			-- Index name which holds class/feature desciption.

	Assembly_header: STRING = "assembly"
			-- Index name which holds name of assembly.

	Once_status_header: STRING = "once_status"
			-- Index name under which globalness of a once is specified.

	option_header: STRING = "option"
			-- Note name under which the attribute may be marked as stable.

	Property_name_header: STRING = "property"
			-- Index name which holds name of an associated property.

	Enum_type_header: STRING = "enum_type"
			-- Type of enum elements.

	storable_version_header: STRING = "storable_version"
			-- Index name under which we will store the version of a class.

	Debugger_header: STRING = "debugger"
			-- Note name under which the attribute may be marked as hidden from debugger.

	global_value: STRING = "global"
			-- Value name of `Once_status_header'.

	stable_option_value: STRING = "stable"
			-- Predefined value of `option_header'.

	transient_option_value: STRING = "transient"
			-- Predefined value of `option_header'.

	is_hidden_in_debugger_call_stack_value: STRING = "is_hidden_in_call_stack"
			-- Predefined value of `Debugger_header'.			

	obsolete_tags: HASH_TABLE [STRING, STRING]
			-- Table indexed by obsoleted indexing tag, where key is new indexing tag that
			-- should be used
		do
			create Result.make (5)
			Result.put (Metadata_header, attribute_header)
			Result.put (Class_metadata_header, Class_attribute_header)
			Result.put (Interface_metadata_header, Interface_attribute_header)
			Result.put (Assembly_metadata_header, Assembly_attribute_header)
		ensure
			obsolete_tags_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal_custom_attributes (tag: STRING): detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Expression representing custom attributes.
		local
			i: detachable INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := index_as_of_tag_name (tag)

			if i /= Void then
					-- Do not care if more than one element has been added
					-- to current INDEX_AS list, we take the first one and
					-- forget about the remaining ones.
				list := i.index_list
				if not list.is_empty then
					from
						list.start
						create Result.make (list.count)
					until
						list.after
					loop
						if attached {CUSTOM_ATTRIBUTE_AS} list.item as ca then
							Result.extend (ca)
						end
						list.forth
					end
				end
			end
		end

	string_value (tag: READABLE_STRING_GENERAL): detachable STRING
			-- String associated with `tag'
			-- Void if not a string or not tag `tag'
		require
			tag_attached: tag /= Void
			not_tag_is_empty: not tag.is_empty
		local
			i: detachable INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := index_as_of_tag_name (tag)

			if i /= Void then
				list := i.index_list
				create Result.make (20)
				from
					list.start
				until
					list.after
				loop
					if attached {STRING_AS} list.item as s then
						Result.append (s.value)
						list.forth
						if not list.after and s /= Void then
							Result.append (", ")
						end
					else
						list.forth
					end
				end
			end
		end

	has_tag_value (a_tag, a_value: READABLE_STRING_8): BOOLEAN
			-- Does current have an indexing clause tag `a_tag' with value `a_value' as either identifier or string.
		local
			i: detachable INDEX_AS
			list: EIFFEL_LIST [ATOMIC_AS]
		do
			i := index_as_of_tag_name (a_tag)
			if i /= Void then
				list := i.index_list
				if not list.is_empty then
					from
						list.start
					until
						list.after or Result
					loop
						Result :=
							(attached {STRING_AS} list.item as s and then s.value.is_case_insensitive_equal (a_value)) or else
							(attached {ID_AS} list.item as id and then id.name.is_case_insensitive_equal (a_value))
						list.forth
					end
				end
			end
		end

feature -- Roundtrip

	indexing_keyword_index: INTEGER
			-- Index of keyword "indexing" associated with current AST node

	end_keyword_index: INTEGER
			-- Index of keyword "end" associated with current AST node

	indexing_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "indexing" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, indexing_keyword_index)
		end

	end_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "end" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, end_keyword_index)
		end

	set_indexing_keyword (a_keyword: like indexing_keyword)
			-- Set `indexing_keyword' with `a_keyword'.
		do
			if a_keyword /= Void then
				indexing_keyword_index := a_keyword.index
			end
		ensure
			indexing_keyword_set: a_keyword /= Void implies indexing_keyword_index = a_keyword.index
		end

	set_end_keyword (a_keyword: like end_keyword)
			-- Set `end_keyword' with `a_keyword'.
		do
			if a_keyword /= Void then
				end_keyword_index := a_keyword.index
			end
		ensure
			end_keyword_set: a_keyword /= Void implies end_keyword_index = a_keyword.index
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
