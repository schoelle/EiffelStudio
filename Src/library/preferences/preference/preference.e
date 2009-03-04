note
	description: "Resource type abstraction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCE

feature -- Status setting

	set_name (new_name: STRING)
			-- Set `name' to `new_name'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		do
			name := new_name
		ensure
			name_set: name = new_name
		end

	set_description (new_description: STRING)
			-- Set `description' to `new_description'.
		require
			new_description_exists: new_description /= Void
			new_description_not_empty: not new_description.is_empty
		do
			description := new_description
		ensure
			description_set: description = new_description
		end

	set_hidden (a_flag: BOOLEAN)
			-- Set if this is hidden from user view.
		do
			is_hidden := a_flag
		ensure
			value_set: is_hidden = a_flag
		end

	set_default_value (a_value: STRING)
			-- Set the value to be used for default in the event `value' is not set.
		require
			a_value_not_void: a_value /= Void
			a_value_valid: valid_value_string (a_value)
		do
			internal_default_value := a_value
			if internal_change_actions /= Void then
				internal_change_actions.call ([Current])
			end
		ensure
			default_value_set: internal_default_value = a_value
		end

	set_value_from_string (a_value: STRING)
			-- Parse the string value `a_value' and set `value'.
		require
			a_value_not_void: a_value /= Void
			a_value_valid: valid_value_string (a_value)
		deferred
		end

	reset
			-- Reset value to `default_value'.
		require
			has_default_value: has_default_value
		do
			if auto_preference /= Void then
				set_value_from_string (auto_preference.string_value)
			else
				set_value_from_string (default_value)
			end
		ensure
			is_reset: is_default_value
		end

	set_restart_required (is_required: BOOLEAN)
			-- Set 'restart_required'
		do
			restart_required := is_required
		ensure
			restart_required_set: restart_required = is_required
		end

feature -- Access

	name: STRING
			-- Name of the preference as it appears in the preference file.

	description: STRING
			-- Description of what the preference is all about.

	default_value: STRING
			-- Value to be used for default.
		do
			if auto_preference = Void then
				Result := internal_default_value
			else
				Result := auto_preference.string_value
			end
		end

	string_value: STRING
			-- String value for this preference.
		require
			has_value: has_value
		deferred
		ensure
			not_void: Result /= Void
		end

	string_type: STRING
			-- String description of this preference type.
		deferred
		ensure
			string_type_not_void: Result /= Void
		end

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		deferred
		ensure
			generating_preference_type_not_void: Result /= Void
		end

	manager: PREFERENCE_MANAGER
			-- Manager to which Current belongs.

	auto_preference: like Current
			-- Preference to use for auto color.

feature -- Query

	has_value: BOOLEAN
			-- Does this preference have a value to use?
		deferred
		end

	has_default_value: BOOLEAN
			-- Does this preference have a default value to use?
		do
			Result := default_value /= Void	or auto_preference /= Void
		end

	is_default_value: BOOLEAN
			-- Is this preference value the same as the default value?
		do
			if has_default_value then
				Result := string_value.as_lower.is_equal (default_value.as_lower)
			end
		end

	is_hidden: BOOLEAN
			-- Should Current be hidden from user view?

	valid_value_string (a_string: STRING): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		require
			string_not_void: a_string /= Void
		deferred
		end

	restart_required: BOOLEAN
			-- Is a restart required to apply the preference when changed? (Default: False)

	is_auto: BOOLEAN
			-- Is Current using auto value?		

feature -- Actions

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `value' changes, after call to `set_value'.
		do
			Result := internal_change_actions
			if Result = Void then
				create Result
				internal_change_actions := Result
			end
		end

feature {NONE} -- Implementation

	internal_change_actions: like change_actions
			-- Storage for `change_actions'.

	auto_string: STRING = "auto"
			-- Auto

	internal_default_value: STRING
			-- Internal default value

invariant
	has_manager: manager /= Void
	name_not_void: name /= Void
	has_change_actions: change_actions /= Void

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




end -- class PREFERENCE
