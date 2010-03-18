note
	description: "Eiffel Vision tree node. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		undefine
			copy, is_equal
		redefine
			parent_imp,
			interface
		select
			interface
		end

	EV_ITEM_IMP
		undefine
			set_pnd_original_parent,
			pixmap_equal_to,
			parent,
			copy, is_equal
		redefine
			parent_imp,
			destroy,
			interface,
			set_pixmap,
			remove_pixmap,
			on_parented,
			on_orphaned,
			pixmap
		end

	EV_TEXTABLE_IMP
		undefine
			copy, is_equal
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		undefine
			copy, is_equal
		redefine
			interface,
			set_tooltip,
			destroy
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE, EV_TREE_NODE_IMP]
		rename
			interface as il_interface
		undefine
			copy, is_equal
		redefine
			initialize
		end

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			set_text as wel_set_text,
			make as wel_make,
			children as children_nb,
			item as wel_item
		redefine
			wel_set_text,
			wel_text
		end

	WEL_TVIS_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_TVM_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_ILC_CONSTANTS
		export {NONE}
			all
		undefine
			copy, is_equal
		end

	EV_TREE_NODE_ACTION_SEQUENCES_IMP
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			create ev_children.make (1)
			create real_text.make (0)
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)

				-- By default, no image.
			has_pixmap := False
			image_index := 0
			set_image (image_index, image_index)
		end

	initialize
			-- Perfrom post creation initialization on `Current'.
		do
			Precursor
			create internal_children.make (1)
			set_is_initialized (True)
		end

feature {EV_ANY_I}-- Access

	parent_imp: EV_ITEM_LIST_IMP [EV_TREE_NODE, EV_TREE_NODE_IMP]
			-- Parent implementation.

	top_parent_imp: EV_TREE_IMP
			-- Implementation of `parent_tree'.
		local
			loc_parent_tree: like parent_tree
		do
			loc_parent_tree := parent_tree
			if loc_parent_tree /= Void then
				Result ?= loc_parent_tree.implementation
				check
					parent_tree_not_void: Result /= Void
				end
			end
		end

	pixmap: EV_PIXMAP
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			image_icon: WEL_ICON
			image_list: EV_IMAGE_LIST_IMP
		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					image_list := top_parent_imp.image_list
					image_icon := image_list.get_icon (image_index, Ild_normal)
					-- We now set the brivate bitmap id as we want to ensure when it is placed back in
						-- the image list, the icon already contained is used.
					pix_imp.set_private_bitmap_id (image_list.image_id_to_bitmap_id_index.item (image_index))
					image_icon.enable_reference_tracking
					pix_imp.set_with_resource (image_icon)
					image_icon.decrement_reference
				else
					Result := private_pixmap
				end
			end
		end

feature {EV_ANY_I} -- Status report

	ev_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- List of the direct children of `Current'.

	is_selected: BOOLEAN
			-- Is `Current' selected?
		do
			Result := top_parent_imp.is_selected (Current)
		end

	is_expanded: BOOLEAN
			-- is `Current' expanded ?
		do
			Result := top_parent_imp.is_expanded (Current)
		end

	is_parent: BOOLEAN
			-- is `Current' the parent of other items?
		do
			if top_parent_imp /= Void then
				Result := top_parent_imp.is_parent (Current)
			else
				Result := not internal_children.is_empty
			end
		end

feature {EV_ANY_I} -- Status setting

	set_parent_imp (a_parent_imp: like parent_imp)
			-- Make `a_parent_imp' the new parent of the widget.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
			else
				parent_imp := Void
			end
		end

	destroy
			-- Destroy `Current'.
		do
			Precursor {EV_ITEM_IMP}
			internal_children := Void
		end

	enable_select
			-- Select `Current'.
		do
			top_parent_imp.select_item (Current)
		end

	disable_select
			-- Deselect `Current'.
		do
			if top_parent_imp /= Void then
				top_parent_imp.deselect_item (Current)
			end
		end

	set_expand (flag: BOOLEAN)
			-- Expand `Current' if `flag', else collapse `Current'.
		do
			if flag then
				top_parent_imp.expand_item (Current)
			else
				top_parent_imp.collapse_item (Current)
			end
		end

feature {EV_ANY_I} -- Element change

	wel_text: STRING_32
			-- Text of `Current'.
		do
			if real_text /= Void then
				Result := real_text.twin
			end
		end

	text_length: INTEGER
			-- Number of characters in `text'.
		do
			Result := real_text.count
		end

	real_text: STRING_32
			-- Internal `text'.

	wel_set_text (txt: STRING_GENERAL)
			-- Make `txt' the new label of `Current'.
		local
			tree: EV_TREE_IMP
		do
			real_text := txt.twin
			set_mask (Tvif_text)
			Precursor (txt)
			tree := top_parent_imp
			if tree /= Void then
				tree.notify_item_info (Current)
			end
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			if parent_tree /= Void then
				Result := screen_x - parent_tree.screen_x
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if parent_tree /= Void then
				Result := screen_y - parent_tree.screen_y
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			load_bounds_rect
			Result := bounds_rect.left
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			load_bounds_rect
			Result := bounds_rect.top
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			load_bounds_rect
			Result := bounds_rect.width
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			load_bounds_rect
			Result := bounds_rect.height
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			Result := width
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	--| This is redundent in this class.
	--| The events are only propagated to the tree, not a tree node.
	--| These features are required by any parent of items, however, as
	--| in this case, the parent is an item as well, they will never
	--| recieve any events. Cannot see an easy way to get rid of this
	--| dependency without complicating the inheritance structure
	--| unecessarily for pick and drop. Julian

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER)
		-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		do
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER)
		-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		do
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TREE_NODE_IMP
			-- `Result' is tree node at pixel position `x_pos', `y_pos'.
		do
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
		end

	disable_default_processing
			-- Disable default window processing.
		do
		end

	on_parented
			-- `Current' has just been parented.
			-- Because this message is only recieved when a tree item becomes
			-- the child of a tree, we need to recurse through all children of
			-- the item and send this message.
		local
			original_index: INTEGER
		do
				-- We process the message only if this item is linked to a tree,
				-- i.e. `top_parent' exists.
			if parent_tree /= Void then
				original_index := ev_children.index
				from
					ev_children.start
				until
					ev_children.off
				loop
					ev_children.item.on_parented
					ev_children.forth
				end
				ev_children.go_i_th (original_index)

					-- Assign `pixmap' to tree.
				set_pixmap_in_parent
			end
		ensure then
			index_not_changed: ev_children.index = old ev_children.index
		end

	on_orphaned
			-- `Current' has just been orphaned.
			-- Because this message is only recieved when a tree item becomes
			-- the child of a tree, we need to recurse through all children of
			-- the item and send this message.
		do
				-- Retrieve the pixmap from the imagelist.
			if has_pixmap and then private_pixmap /= Void then
				private_pixmap := pixmap
			end

			remove_all_direct_references
		ensure then
			index_not_changed: ev_children.index = old ev_children.index
		end

 	remove_all_direct_references
 			-- Recurse through all children and update
 			--`top_parent_imp.current_image_list_info' removing images
 			-- from image list as required.
 		local
 			original_index: INTEGER
 		do
 			original_index := ev_children.index
 			from
 				ev_children.start
 			until
 				ev_children.off
 			loop
 				ev_children.item.remove_all_direct_references
 				ev_children.forth
 			end
 				-- Restore original position in `ev_children.
 			ev_children.go_i_th (original_index)
 		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Pixmap Handling

	has_pixmap: BOOLEAN
			-- Has `Current' a pixmap?

	image_index: INTEGER
			-- Index of pixmap assigned with Current in the imageList.

	set_pixmap (p: EV_PIXMAP)
			-- Assign `p' to the displayed pixmap.
		do
				-- We must destroy the pixmap before we set a new one,
				-- to ensure that we free up Windows GDI objects
			if private_pixmap /= Void then
				private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := p.twin
			has_pixmap := True

				-- If the item is currently contained in the tree then
			if top_parent_imp /= Void then
					-- Update the parent's image list.
				set_pixmap_in_parent
			end
		end

	remove_pixmap
			-- Remove pixmap from `Current'.
		do
			if has_pixmap then
				has_pixmap := False
				if private_pixmap /= Void then
					private_pixmap.destroy
					private_pixmap := Void
				end

					-- If the item is currently contained in the tree then..
				if top_parent_imp /= Void then
						-- Update the parent's image list.
					remove_pixmap_in_parent
				end
			end
		end

	set_pixmap_in_parent
			-- Add/Remove the pixmap to the parent by updating the
			-- parent's image list.
		local
			image_list: EV_IMAGE_LIST_IMP
			root_imp: like top_parent_imp
		do
			root_imp := top_parent_imp

			if has_pixmap then
				image_list := root_imp.image_list
					-- Create the image list and associate it
					-- to the control if it's not already done.
				if image_list = Void then
					root_imp.setup_image_list
					image_list := root_imp.image_list
				end

				if private_pixmap /= Void then
					image_list.add_pixmap (private_pixmap)
					image_index := image_list.last_position
					private_pixmap.destroy
					private_pixmap := Void
				end
			else
				image_index := 0 -- transparent image.
			end
			set_image (image_index, image_index)
			root_imp.set_tree_item (Current)
		end

	remove_pixmap_in_parent
			-- Remove the pixmap from the parent by updating the parent's image
			-- list.
		do
			set_image (0, 0) -- 0 = transparent image.
			top_parent_imp.set_tree_item (Current)
		end

	general_reset_pixmap
			-- Reset the pixmap
			--| For example: if the size of displayed has changed.
		local
			c: like ev_children
		do
				-- Reset the current pixmap
			set_pixmap_in_parent

				-- Reset the pixmap of all children.
			c := ev_children
			from
				c.start
			until
				c.after
			loop
				c.item.general_reset_pixmap
				c.forth
			end
		end

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.twin
		end

feature {EV_TREE_IMP} -- Implementation, pick and drop

	set_pnd_original_parent
			-- Assign `top_parent_imp' to `pnd_original_parent'.
			--| Redefined as the widget is not parent_imp for this
			--| item. See comment in this feature within
			--| EV_PICK_AND_DROPABLE_ITEM_IMP
		do
			pnd_original_parent := top_parent_imp
		end

feature {EV_TREE_IMP} -- Implementation

	internal_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- Holds the children of `Current'.
			--| May be void if `Current' is parented.

	set_internal_children (list: ARRAYED_LIST [EV_TREE_NODE_IMP])
			-- Make `list' the new list of children.
		do
			internal_children := list
		ensure
			internal_children_set: internal_children = list
		end

	relative_position: TUPLE [x_pos: INTEGER; y_pos: INTEGER]
			-- `Result' is position relative to `parent_imp'.
		local
			loop_parent: EV_TREE_NODE_IMP
			counter: INTEGER
			l_top_parent: EV_TREE_IMP
		do
			from
				loop_parent := Current
			until
				loop_parent = Void
			loop
				loop_parent ?= loop_parent.parent_imp
				counter := counter + 1
			end
			create Result
			l_top_parent := top_parent_imp
			if l_top_parent /= Void then
					-- Added protection against the case where `top_parent_imp' is Void.
					-- I do not know why this could occur in a normal EiffelVision2 system,
					-- but some people have custom implementations which fail sometimes.
					-- As this feature has no pre-conditions, we protect against this case
					-- as requested. See bug report 3806. Julian.

				Result.x_pos := top_parent_imp.indent * counter + 1
					--|FIXME The relative y_position is always returned as 0.				
				Result.y_pos := 0
			end
		end

feature {NONE} -- Implementation

	insert_item (item_imp: EV_TREE_NODE_IMP; pos: INTEGER)
			-- Insert `item_imp' at the `index' position.
		do
			if top_parent_imp /= Void then
				if pos = 1 then
					top_parent_imp.general_insert_item
					(item_imp, h_item, Tvi_first, pos)
				else
					top_parent_imp.general_insert_item
					(item_imp, h_item, (ev_children @ (pos - 1)).h_item, pos)
				end
			else
				internal_children.go_i_th (pos)
				internal_children.put_left (item_imp)
			end
		end

	remove_item (item_imp: EV_TREE_NODE_IMP)
			-- Remove `item_imp' from `Current'.
		do
			if top_parent_imp /= Void then
				top_parent_imp.general_remove_item (item_imp)
			else
				internal_children.prune_all (item_imp)
			end
		end

	dragable_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER)
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			-- Not applicable. Required by implementation of EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
			-- as for widgets that contain items, there are correct implementations. It is
			-- of no harm to call this, as it will just do nothing and docking will not occur.
		end

	check_dragable_release (x_pos, y_pos: INTEGER)
			-- End transport if in drag and drop.
		do
			-- Not applicable. Required by implementation of EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
			-- as for widgets that contain items, there are correct implementations. It is
			-- of no harm to call this, as it will just do nothing and docking will not occur.
		end

	ensure_expandable
			-- Ensure `Current' is displayed as expandable.
		do
			insert_i_th (create {EV_TREE_ITEM}, 1)
				-- Now remove the new item from `ev_children'
				-- as we do not wish the item to be accessible from the interface.
			ev_children.wipe_out
		end

	remove_expandable
			-- Ensure `Current' is no longer displayed as expandable.
		local
			l_parent_tree: EV_TREE_IMP
			c: ARRAYED_LIST [EV_TREE_NODE_IMP]
		do
			l_parent_tree ?= parent_imp
			if l_parent_tree /= Void then
				c := l_parent_tree.get_children (Current)
				if c.count > count then
						-- We only remove the extra item if it is actually
						-- there, as determined by the real count compared
						-- to the count as queried from the interface
					l_parent_tree.general_remove_item (c.last)
				end
			elseif internal_children /= Void then
				internal_children.prune_all (internal_children.last)
			end
		end

	bounds_rect: WEL_RECT
			-- Rect struct to hold size information
			-- This is shared and should only be used right after a call to `load_bounds_rect'
		once
			create Result.make (0, 0, 0, 0)
		end

	load_bounds_rect
			-- Load bounds rect.
		local
			a_rect: WEL_RECT
		do
			if top_parent_imp = Void then
				bounds_rect.set_rect (0, 0, 0, 0)
			else
				create a_rect.make (0, 0, 0, 0)
				a_rect.set_left (h_item.to_integer_32)
				if {WEL_API}.send_message_result_boolean (top_parent_imp.wel_item, {WEL_TVM_CONSTANTS}.tvm_getitemrect, {WEL_DATA_TYPE}.to_wparam(1), a_rect.item) then
					bounds_rect.set_rect (parent_tree.screen_x + a_rect.left, parent_tree.screen_y + a_rect.top, parent_tree.screen_x + a_rect.right, parent_tree.screen_y + a_rect.bottom)
				else
					bounds_rect.set_rect (0, 0, 0, 0)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE

invariant
	internal_children_not_void_when_not_parented: is_initialized and top_parent_imp = Void implies internal_children /= Void

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




end -- class EV_TREE_NODE_IMP
