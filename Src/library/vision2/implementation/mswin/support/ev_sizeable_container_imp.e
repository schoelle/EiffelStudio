indexing
	description:
		" A class for MS-Windows to simulate the resizing of%
		% a container";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

deferred class
	EV_SIZEABLE_CONTAINER_IMP

inherit
	EV_SIZEABLE_IMP
		redefine
			internal_set_minimum_width,
			internal_set_minimum_height,
			internal_set_minimum_size,
			integrate_changes,
			minimum_width,
			minimum_height
		end

feature -- Access

	minimum_width: INTEGER is
			-- Minimum width of the window.
			-- We recompute it if necessary.
		do
			if is_minwidth_recomputation_needed then
				if is_minheight_recomputation_needed then
					compute_minimum_size
					set_minheight_recomputation_needed (False)
					compute_minimum_width
				end
				set_minwidth_recomputation_needed (False)
			end
			Result := internal_minimum_width
		end

	minimum_height: INTEGER is
			-- Minimum height of the window.
			-- We recompute it if necessary.
		do
			if is_minheight_recomputation_needed then
				if is_minwidth_recomputation_needed then
					compute_minimum_size
					set_minwidth_recomputation_needed (False)
				else
					compute_minimum_height
				end
				set_minheight_recomputation_needed (False)
			end
			Result := internal_minimum_height
		end

feature -- Basic operations

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			changed: BOOLEAN
		do
			if not is_minwidth_locked then
				changed := internal_minimum_width /= value
				internal_minimum_width := value
				if parent_imp /= Void then
					if managed then
						if changed then 
							parent_imp.notify_change (Nc_minwidth)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width.max (value), height, True)
					end
				end
			elseif displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			changed: BOOLEAN
		do
			if not is_minheight_locked then
				changed := internal_minimum_height /= value
				internal_minimum_height := value
				if parent_imp /= Void then
					if managed then
						if changed then 
							parent_imp.notify_change (Nc_minheight)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width, height.max (value), True)
					end
				end
			elseif displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			w_cd, h_cd: BOOLEAN
			w_ok, h_ok: BOOLEAN
		do
			-- First, we set some local variable
 			w_ok := not is_minwidth_locked
 			h_ok := not is_minheight_locked
 
			-- We check that we are in a coherent status.
			check
				-- If we come here, both of the bits are necessarily set
				-- therefore, we chack only one.
				same_value: is_minwidth_recomputation_needed = is_minheight_recomputation_needed
			end

			-- Then, we properly set the values and propagate the
			-- change if necessary.
			-- The user didn't set the minimum_width nor the minimum_height.
 			if w_ok and h_ok then
 				w_cd := internal_minimum_width /= mw
 				h_cd := internal_minimum_height /= mh
 				internal_minimum_width := mw
 				internal_minimum_height := mh
				if parent_imp /= Void then
	 				if managed then
						if w_cd and h_cd then
							parent_imp.notify_change (Nc_minsize)
						elseif w_cd then
							parent_imp.notify_change (Nc_minwidth)
						elseif h_cd then
							parent_imp.notify_change (Nc_minheight)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width.max (mw), height.max (mh), True)
					end
				end

			-- The user did set the minimum_height already.
			elseif w_ok then
				w_cd := internal_minimum_width /= mw
				internal_minimum_width := mw
				if parent_imp /= Void then
					if managed then
						if w_cd then
							parent_imp.notify_change (Nc_minwidth)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width.max (mw), height, True)
					end
				end

			-- The user did set the minimum_height already.
			elseif h_ok then
				h_cd := internal_minimum_height /= mh
				internal_minimum_height := mh
				if parent_imp /= Void then
					if managed then
						if h_cd then
								parent_imp.notify_change (Nc_minheight)
						elseif displayed then
							move_and_resize (x, y, width, height, True)
						end
					else
						move_and_resize (x, y, width, height.max (mh), True)
					end
				end

			-- The user did set everything already.
 			elseif displayed then
 				move_and_resize (x, y, width, height, True)
 			end
		end

	notify_change (type: INTEGER) is
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown, 
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			mw, mh: INTEGER
			mw_not_needed, mh_not_needed: BOOLEAN
		do
			inspect type
			when Nc_minwidth then
				if not is_minwidth_recomputation_needed then
					set_minwidth_recomputation_needed (True)
					if displayed then
						compute_minimum_width
						set_minwidth_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth)
						end
					end
				end
			when Nc_minheight then
				if not is_minheight_recomputation_needed then
					set_minheight_recomputation_needed (True)
					if displayed then
						compute_minimum_height
						set_minheight_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minheight)
						end
					end
				end
			when Nc_minsize then
				mw_not_needed := not is_minwidth_recomputation_needed
				mh_not_needed := not is_minheight_recomputation_needed

				if mw_not_needed and mh_not_needed then
					set_minwidth_recomputation_needed (True)
					set_minheight_recomputation_needed (True)
					if displayed then
						compute_minimum_size
						set_minwidth_recomputation_needed (False)
						set_minheight_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minsize)
						end
					end
				elseif mw_not_needed then
					set_minwidth_recomputation_needed (True)
					if displayed then
						compute_minimum_width
						set_minwidth_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth)
						end
					end
				elseif mh_not_needed then
					set_minheight_recomputation_needed (True)
					if displayed then
						compute_minimum_height
						set_minheight_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minheight)
						end
					end
				end
			end
		end

	integrate_changes is
			-- A fonction that simply recompute the minimum size if
			-- necessary. It do not resize the widget, only integrate
			-- the changes.
		local
			mw_needed, mh_needed: BOOLEAN
		do
			mw_needed := is_minwidth_recomputation_needed
			mh_needed := is_minheight_recomputation_needed

			-- We recompute what is necessary
			if mw_needed and mh_needed then
				compute_minimum_size
			elseif mw_needed then
				compute_minimum_width
			elseif mh_needed then
				compute_minimum_height
			end
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute the minimum_width of the object.
			-- Should call only set_internal_minimum_width.
		do
			if displayed then
				move_and_resize (x, y, width, height, True)
			end
		end

feature -- Deferred

	displayed: BOOLEAN is
			-- Is the window displayed on the screen?
			-- ie : is parent and current widget shown.
		deferred
		end

end -- class EV_CONTAINER_SIZEABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
