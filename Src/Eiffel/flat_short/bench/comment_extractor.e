indexing
	description: "[
		Used for extracting comments from a routine and displaying inherited comments, when appropriate.
		
		Current there is a comment specification for injecting inherited comments into an existing feature's comment:
		
		Using the comment <Precursor> will inject the first matched redefined feature's comment, from a parent declaration.
		To be more specific, you can use <Precursor {CLASS_NAME}> where CLASS_NAME is the name of the class where the
		feature is redefined from. Multiple <Precursor> comments can be used, with class name, to allow for comments from multiple
		classes.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	COMMENT_EXTRACTOR

feature -- Query

	feature_comments (a_feature: !E_FEATURE): ?EIFFEL_COMMENTS
			-- Retrieve's the feature comments from a given compiled feature.
			--
			-- `a_feature': The feature to show comments for.
			-- `Result': A list of tokens or Void if no comments were found.
		do
			Result := feature_comments_ex (a_feature, False)
		end

	feature_comments_ex (a_feature: !E_FEATURE; a_show_impl: BOOLEAN): ?EIFFEL_COMMENTS is
			-- Retrieve's the feature comments from a given compiled feature, with the option to include implementation comments
			--
			-- `a_feature': The feature to show comments for.
			-- `a_show_impl': True if the feature's implmentation comments should be displayed; False otherwise.
			-- `Result': A list of tokens or Void if no comments were found.
		local
			l_parent_comments: ?EIFFEL_COMMENTS
			l_parent_feature: ?like find_ancestors_feature
			l_comments: EIFFEL_COMMENTS
			l_comment: EIFFEL_COMMENT_LINE
			l_string: STRING_8
			l_leaf: LEAF_AS_LIST
			l_stop: BOOLEAN
			l_comments_emitted: BOOLEAN
		do
			create Result.make

			if {l_mls: !MATCH_LIST_SERVER} a_feature.system.match_list_server then
				l_leaf := l_mls.item (a_feature.written_class.class_id)
				if l_leaf /= Void then
					l_comments := a_feature.ast.comment (l_leaf)
					if l_comments /= Void and then not l_comments.is_empty then
						from
							l_comments.start
						until
							l_comments.after
						loop
							l_comment := l_comments.item
							if a_show_impl or else not l_comment.is_implementation then
									-- Add only actual comments, because implementation comments should not be shown (unless requested)
								l_string := l_comment.content
								if not l_string.is_empty and then l_string.occurrences (' ') + l_string.occurrences ('%T') /= l_string.count then
										-- Non blank comments
									l_comments_emitted := True

										-- Determine if inherited comments should be used
									original_comment_reg_ex.match (l_string)
									if original_comment_reg_ex.has_matched then
											-- The comment is actually a inherited comment reference
										if original_comment_reg_ex.match_count = 3 then
												-- The comment contains a inherited type specifier, take the comment from a particular type.
											l_parent_feature := find_ancestors_feature (a_feature, original_comment_reg_ex.captured_substring (2))
										else
											l_parent_feature := find_ancestors_feature (a_feature, Void)
										end
										if l_parent_feature /= Void then
											l_parent_comments := feature_comments_ex (l_parent_feature, False)
											if l_parent_comments /= Void and then not l_parent_comments.is_empty then
													-- Add parent comments and re-adjust the cursor index to skip the parent comments.
												Result.append (l_parent_comments)
											end
										end
									else
											-- Recreate the line to remove all stored position information.
										Result.extend (create {EIFFEL_COMMENT_LINE}.make_from_string (l_comment.content))
									end
								elseif l_comments_emitted then
										-- Allows blank lines to be included in the comments, only if real comments have been added first.
									Result.extend (create {EIFFEL_COMMENT_LINE}.make_from_string (""))
								end
							end

							l_comments.forth
						end
					else
							-- There are no comments, try the parent
						l_parent_feature := find_ancestors_feature (a_feature, Void)
						if l_parent_feature /= Void then
							l_parent_comments := feature_comments_ex (l_parent_feature, False)
							if l_parent_comments /= Void and then not l_parent_comments.is_empty then
								Result.append (l_parent_comments)
							end
						end

					end

					if not Result.is_empty then
							-- Trim empty lines from the end of comment list
						from
							l_stop := False
							Result.finish
						until
							Result.before or l_stop
						loop
							l_comment := Result.item
							l_string := l_comment.content
							if l_string.is_empty or else l_string.occurrences (' ') + l_string.occurrences ('%T') = l_string.count then
								if Result.isfirst then
									Result.remove
								else
									Result.back
									Result.remove_right
								end
							else
								l_stop := True
							end
						end
					end
				end
			end

			if Result.is_empty then
				Result := Void
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

feature {NONE} -- Query

	find_ancestors_feature (a_feature: !E_FEATURE; a_parent_name: ?STRING_8): ?E_FEATURE
			-- Attepts to locate an ancestor feature. This also respects ancestor features for attributes.
			--
			-- `a_feature': The feature to locate a first parent from.
			-- `a_parent_name': An optional parent class name to use when extracting inherited comments.
			-- `Result': A parent feature or Void if no match could be found.
		require
			not_a_parent_name_is_empty: a_parent_name /= Void implies not a_parent_name.is_empty
		do
			if {l_class: CLASS_C} a_feature.associated_class then
				Result := find_ancestors_feature_internal (a_feature, l_class, a_parent_name, create {ARRAYED_LIST [!CLASS_C]}.make (20))
			end
		end

feature {NONE} -- Regular expressions

	original_comment_reg_ex: RX_PCRE_MATCHER
			-- Pattern to match a original comment specification with an optional precursor class name
		once
			create Result.make
			Result.compile ("^[\ \t]*<[\ \t]*[Pp][Rr][Ee][Cc][Uu][Rr][Ss][Oo][Rr][\ \t]*({([A-Z][A-Z_0-9]*)\}[\ \t]*>|>)[ \t]*$")
		ensure
			result_is_compiled: Result.is_compiled
		end

feature {NONE} -- Implementation: Query

	find_ancestors_feature_internal (a_feature: !E_FEATURE; a_class: !CLASS_C; a_parent_name: ?STRING_8; a_processed: !ARRAYED_LIST [!CLASS_C]): ?E_FEATURE
			-- Attepts to locate an ancestor feature. This also respects ancestor features for attributes.
			--
			-- `a_feature': The feature to locate a first parent from.
			-- `a_class': A context class
			-- `a_parent_name': An optional parent class name to use when extracting inherited comments.
			-- `a_processed': The active list of processed parent classes.
			-- `Result': A parent feature or Void if no match could be found.
		require
			not_a_parent_name_is_empty: a_parent_name /= Void implies not a_parent_name.is_empty
			not_a_processed_has_a_class: not a_processed.has (a_class)
		local
			l_rout_id_set: ROUT_ID_SET
			l_parents: FIXED_LIST [CL_TYPE_A]
			l_matched_parent: BOOLEAN
			l_count, i: INTEGER
		do
			l_rout_id_set := a_feature.rout_id_set
			l_parents := a_class.parents
			if not l_parents.is_empty then
				from l_parents.start until l_parents.after or Result /= Void or l_matched_parent loop
					if {l_parent: CLASS_C} l_parents.item.associated_class and then not a_processed.has (l_parent) then
							-- The parent class has not get been processed.
						l_matched_parent := a_parent_name /= Void and then l_parent.name_in_upper.is_equal (a_parent_name)
						if a_parent_name = Void or l_matched_parent then
								-- Search matching parent for the associated feature
							from
								l_count := l_rout_id_set.count
								i := 1
							until
								i > l_count or Result /= Void
							loop
								Result := l_parent.feature_with_rout_id (l_rout_id_set.item (i))
								i := i + 1
							end
						end
						a_processed.extend (l_parent)
						if Result = Void and then not l_matched_parent then
								-- If the requested parent name was match then this code should not be execute!
							Result := find_ancestors_feature_internal (a_feature, l_parent, a_parent_name, a_processed)
						end
					end
					l_parents.forth
				end
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
