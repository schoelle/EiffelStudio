indexing
	description: "Objects that casts the projector in EV_MODEL_WORLD_CELL to EIFFEL_PROJECTOR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FIGURE_WORLD_CELL

inherit
	EV_MODEL_WORLD_CELL
		redefine
			projector,
			on_pointer_button_press_on_drawing_area,
			on_pointer_button_release_on_drawing_area,
			initialize,
			on_mouse_wheel_on_drawing_area
		end
		
	EB_CONSTANTS
		undefine
			copy,
			default_create
		end

create
	make_with_world,
	make_with_world_and_tool
	
feature {NONE} -- Initialization

	make_with_world_and_tool (a_world: like world; a_tool: like tool) is
			-- 
		require
			a_world_not_Void: a_world /= Void
			a_tool_not_Void: a_tool /= Void
		do
			make_with_world (a_world)
			tool := a_tool
		ensure
			set: tool = a_tool
		end

	initialize is
			-- 
		do
			Precursor {EV_MODEL_WORLD_CELL}
			drawing_area.set_pointer_style (cursors.open_hand_cursor)
		end
		
	
feature -- Access

	projector: EIFFEL_PROJECTOR
			-- The projector used to project the `world'.
			
	tool: EB_CONTEXT_EDITOR

feature {NONE} -- Implementation

	on_pointer_button_press_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was pressed in `drawing_area'.
		do
			if button = 1 then
				if projector.is_figure_selected then
					is_scroll := True	
				elseif not ev_application.ctrl_pressed then
					drawing_area.set_pointer_style (cursors.closed_hand_cursor)
					is_hand := True
					start_x := ax
					start_y := ay
					start_horizontal_value := horizontal_scrollbar.value
					start_vertical_value := vertical_scrollbar.value
					drawing_area.enable_capture
				else
					is_scroll := True
				end
			end
		end
		
	on_pointer_button_release_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was released over `drawing_area'.
		do
			if is_scroll then
				is_scroll := False
			end
			if is_hand then
				is_hand := False
				drawing_area.set_pointer_style (cursors.open_hand_cursor)
				drawing_area.disable_capture
			end
		end
		
	on_mouse_wheel_on_drawing_area (i: INTEGER) is
			-- User moved mouse wheel.
		local
			l_world: EIFFEL_WORLD
			new_scale_factor, l_scale_factor: DOUBLE
			l_zoom_selector: EB_ZOOM_SELECTOR
			new_scale, old_scale: INTEGER
			l_projector: EIFFEL_PROJECTOR
			step: INTEGER
		do
			if ev_application.ctrl_pressed then
				if tool /= Void then
					if i <= -1 then
						l_world := tool.world
						l_scale_factor := l_world.scale_factor
						new_scale_factor := (0.1 + l_scale_factor) / l_scale_factor
						old_scale := (l_world.scale_factor * 100).rounded
						l_world.scale (new_scale_factor)
						tool.crop_diagram
						l_projector := tool.projector
						l_projector.full_project
						new_scale := (l_world.scale_factor * 100).rounded
						l_zoom_selector := tool.zoom_selector
						l_zoom_selector.show_as_text (new_scale)
						tool.history.register_named_undoable (
								Interface_names.t_Diagram_zoom_in_cmd,
								[<<agent l_world.scale (new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
								[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
					else
						l_world := tool.world
						l_scale_factor := l_world.scale_factor
						new_scale_factor := (0.1 - l_scale_factor) / -l_scale_factor
						if l_world.scale_factor * new_scale_factor > 0.1 then
							old_scale := (l_world.scale_factor * 100).rounded
							l_world.scale (new_scale_factor)
							tool.crop_diagram
							l_projector := tool.projector
							l_projector.full_project
							new_scale := (l_world.scale_factor * 100).rounded
							l_zoom_selector := tool.zoom_selector
							l_zoom_selector.show_as_text (new_scale)
							tool.history.register_named_undoable (
									Interface_names.t_Diagram_zoom_out_cmd,
									[<<agent l_world.scale (new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
									[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
						end
					end
				end
			else
				if ev_application.shift_pressed then
					step := (horizontal_scrollbar.value_range.count * 0.1).truncated_to_integer
					if i >= 1 then
						horizontal_scrollbar.set_value ((horizontal_scrollbar.value - step).max (horizontal_scrollbar.value_range.lower))
					else
						horizontal_scrollbar.set_value ((horizontal_scrollbar.value + step).min (horizontal_scrollbar.value_range.upper))
					end
				else
					step := (vertical_scrollbar.value_range.count * 0.1).truncated_to_integer
					if i >= 1 then
						vertical_scrollbar.set_value ((vertical_scrollbar.value - step).max (vertical_scrollbar.value_range.lower))
					else
						vertical_scrollbar.set_value ((vertical_scrollbar.value + step).min (vertical_scrollbar.value_range.upper))
					end
				end
			end
		end
		

end -- class EIFFEL_FIGURE_WORLD_CELL
