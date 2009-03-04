note
	description	: "Array preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date:"
	revision	: "$Revision$"

class
	ARRAY_PREFERENCE

inherit
	TYPED_PREFERENCE [ARRAY [STRING]]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING
			-- String representation of `value'.				
		local
			index: INTEGER
			l_value: STRING
		do
			create Result.make_empty
			from
				index := value.lower
			until
				index > value.upper
			loop
				l_value := value.item (index)
				if is_choice and then index = selected_index then
					Result.append ("[" + l_value + "]")
				else
					Result.append (l_value)
				end
				if not (index = value.count) then
					Result.append (";")
				end
				index := index + 1
			end
		end

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "LIST"
		end

	selected_value: STRING
			-- Value of the selected index.
		do
			if value.valid_index (selected_index) then
				Result := value.item (selected_index)
			end
		end

	selected_index: INTEGER
			-- Selected index from list.

feature -- Status Setting

	set_is_choice (a_flag: BOOLEAN)
			-- Set `is_choice' to`a_flag'.
		do
			is_choice := a_flag
			if selected_index = 0 then
				selected_index := 1
			end
		end

	set_selected_index (a_index: INTEGER)
			-- Set `selected_index'
		require
			index_valie: a_index > 0
			is_choice: is_choice
		do
			selected_index := a_index
		ensure
			index_set: selected_index = a_index
		end

	set_value_from_string (a_value: STRING)
			-- Parse the string value `a_value' and set `value'.
		local
			cnt: INTEGER
			l_value: STRING
			values: LIST [STRING]
		do
			create internal_value.make (1, 0)
			values := a_value.split (';')
			if values.count > 1 or not values.first.is_empty then
				from
					values.start
					cnt := 1
				until
					values.after
				loop
					l_value := values.item
					if not l_value.is_empty and then l_value.item (1) = '[' and then l_value.item (l_value.count) = ']' then
						l_value := l_value.substring (2, l_value.count - 1)
						is_choice := True
						set_selected_index (cnt)
					end
					value.force (l_value, cnt)
					values.forth
					cnt := cnt + 1
				end
			end
			set_value (internal_value)
		end

feature -- Query

	is_choice: BOOLEAN
			-- Is this preference a single choice or the full list?

	valid_value_string (a_string: STRING): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?		
		do
			Result := a_string /= Void
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		do
			if is_choice then
				Result := "COMBO"
			else
				Result := "TEXT"
			end
		end

feature {NONE} -- Implementation

	auto_default_value: ARRAY [STRING]
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make (0, 1)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class ARRAY_PREFERENCE
