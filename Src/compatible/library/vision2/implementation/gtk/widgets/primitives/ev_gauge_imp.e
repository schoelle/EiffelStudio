note
	description: "Eiffel Vision gauge. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_GAUGE_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize
		end

	EV_GAUGE_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the horizontal scroll bar.
		do
			base_make (an_interface)
			adjustment := {EV_GTK_EXTERNALS}.gtk_adjustment_new (0.0, 0.0, 100.0, 1.0, 10.0, 0.0)
		end

	initialize
		do
			Precursor {EV_PRIMITIVE_IMP}
			ev_gauge_imp_initialize
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_redraw_on_allocate (c_object, True)
		end

	ev_gauge_imp_initialize
			-- Initialize without calling precursor.
			--| Separate function so it can be called from
			--| widgets that inherit twice from EV_WIDGET_IMP,
			--| so initialize does not have to be called again.
		do
			create value_range.make (0, 100)
			value_range.change_actions.extend (agent set_range)
			real_signal_connect (
				adjustment,
				once "value-changed",
				agent (App_implementation.gtk_marshal).on_gauge_value_changed_intermediary (c_object),
				Void
			)
			set_range
		end

feature -- Access

	value: INTEGER
			-- Current value of the gauge.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (adjustment).rounded
		end

	step: INTEGER
			-- Value by which `value' is increased after `step_forward'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_step_increment (adjustment).rounded
		end

	leap: INTEGER
			-- Value by which `value' is increased after `leap_forward'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_page_increment (adjustment).rounded
		end

	page_size: INTEGER
			-- Size of slider.
			--| We define it here to add to the internal maximum.
			--| Value should be zero for ranges but not for scrollbars.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_page_size (adjustment).rounded
		end

feature -- Status setting

	step_forward
			-- Increment `value' by `step' if possible.
		do
			set_value (value_range.upper.min (value + step))
		end

	step_backward
			-- Decrement `value' by `step' if possible.
		do
			set_value (value_range.lower.max (value - step))
		end

	leap_forward
			-- Increment `value' by `leap' if possible.
		do
			set_value (value_range.upper.min (value + leap))
		end

	leap_backward
			-- Decrement `value' by `leap' if possible.
		do
			set_value (value_range.lower.max (value - leap))
		end

feature -- Element change

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			internal_set_value (a_value)
				-- Make sure value is immediately displayed on screen.
			refresh_now
		ensure then
			step_same: step = old step
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_step (a_step: INTEGER)
			-- Set `step' to `a_step'.
		do
			if step /= a_step then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_step_increment (adjustment, a_step)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (adjustment)
			end
		ensure then
			value_same: value = old value
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_leap (a_leap: INTEGER)
			-- Set `leap' to `a_leap'.
		do
			if leap /= a_leap then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_upper (adjustment, value_range.upper)
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_page_increment (adjustment, a_leap)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (adjustment)
			end
		end

	set_range
			-- Update widget range from `value_range'
		local
			temp_value: INTEGER
		do
			temp_value := value
			if temp_value > value_range.upper then
				temp_value := value_range.upper
			elseif temp_value < value_range.lower then
				temp_value := value_range.lower
			end
			{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_lower (adjustment, value_range.lower.to_real)
			internal_set_upper
			internal_set_value (temp_value)
			{EV_GTK_EXTERNALS}.gtk_adjustment_changed (adjustment)
		end

feature {NONE} -- Implementation

	internal_set_upper
			-- Set the upper value of the adjustment struct
		do
			{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_upper (
				adjustment,
				value_range.upper.to_real
			)
		end

	interface: EV_GAUGE

	adjustment: POINTER
			-- Pointer to GtkAdjustment of gauge.

	old_value: INTEGER
			-- Value of `value' when last "value-changed" signal occurred.

	internal_set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			if value /= a_value then
				{EV_GTK_EXTERNALS}.gtk_adjustment_set_value (adjustment, a_value.to_real)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	value_changed_handler
			-- Called when `value' changes.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call ([value])
			end
		end

invariant
	adjustment_not_void: adjustment /= NULL

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GAUGE_I

