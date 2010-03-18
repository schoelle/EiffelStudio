note
	description: "EiffelVision drawable. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, primitives, drawing, line, point, ellipse"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_IMP

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_DRAWABLE_CONSTANTS

	DISPOSABLE
		undefine
			copy,
			default_create
		end

	PLATFORM
		undefine
			copy,
			default_create
		end

	MATH_CONST


feature {NONE} -- Initialization

	initialize
			-- Set default values. Call during initialization.
		do
			create image.make_with_size (create {NS_SIZE}.make_size (1000, 1000))
        	create internal_background_color.make_with_rgb (1, 1, 1)
        	create internal_foreground_color.make_with_rgb (0, 0, 0)
		end

feature {EV_DRAWABLE_IMP, EV_APPLICATION_IMP} -- Implementation

	height: INTEGER
			-- Needed by `draw_straight_line'.
		deferred
		end

	width: INTEGER
			-- Needed by `draw_straight_line'.
		deferred
		end

feature -- Access

	font: EV_FONT
			-- Font used for drawing text.
		do
			if internal_font_imp /= Void then
				Result := internal_font_imp.interface.twin
			else
				create Result
			end
		end

	foreground_color: EV_COLOR
			-- Color used to draw primitives.
		do
			Result := internal_foreground_color
		end

	background_color: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.
		do
			Result := internal_background_color
		end

	line_width: INTEGER
			-- Line thickness.
		do
			Result := internal_line_width
		end

	drawing_mode: INTEGER
			-- Logical operation on pixels when drawing.

	clip_area: EV_RECTANGLE
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.

	tile: EV_PIXMAP
			-- Pixmap that is used to fill instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?
		do
			Result := internal_dashed_line_style
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Set `font' to `a_font'.
		do
			if internal_font_imp /= a_font.implementation then
				internal_font_imp ?= a_font.implementation
			end
		end

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'.
		do
			internal_background_color := a_color
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			internal_foreground_color := a_color
		end

	set_line_width (a_width: INTEGER)
			-- Assign `a_width' to `line_width'.
		do
			internal_line_width := a_width
		end

	set_drawing_mode (a_mode: INTEGER)
			-- Set drawing mode to `a_mode'.
		do
			drawing_mode := a_mode
			inspect drawing_mode
				when drawing_mode_and then
				when drawing_mode_copy then
				when drawing_mode_invert then
				when drawing_mode_or then
				when drawing_mode_xor then
			end
		end

	set_clip_area (an_area: EV_RECTANGLE)
			-- Set an area to clip to.
		do
			clip_area := an_area
		end

	set_clip_region (a_region: EV_REGION)
			-- Set a region to clip to.
		do

		end

	remove_clipping
			-- Do not apply any clipping.
		do
			clip_area := void
		end

	set_tile (a_pixmap: EV_PIXMAP)
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do

		end

	remove_tile
			-- Do not apply a tile when filling.
		do
		end

	enable_dashed_line_style
			-- Draw lines dashed.
		do
			internal_dashed_line_style := true
		end

	disable_dashed_line_style
			-- Draw lines solid.
		do
			internal_dashed_line_style := false
		end

feature -- Clearing operations

	clear
			-- Erase `Current' with `background_color'.
		do
			clear_rectangle (0, 0, width, height)
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER)
			-- Erase rectangle specified with `background_color'.
		local
			path: NS_BEZIER_PATH
			color: EV_COLOR_IMP
		do
			image.lock_focus
			color ?= background_color.implementation
			color.color.set
			create path.make_with_rect ( create {NS_RECT}.make_rect (x, y, a_width, a_height) )
			path.fill
			image.unlock_focus
			update_if_needed
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER)
			-- Draw point at (`x', `y').
		do
			draw_segment (x, y, x, y+1)
		end

	draw_text (x, y: INTEGER; a_text: STRING_GENERAL)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			-- fixme: should be the baseline
			draw_text_top_left (x, y, a_text)
		end

	draw_rotated_text (x, y: INTEGER; angle: REAL; a_text: STRING_GENERAL)
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of radians counter-clockwise from horizontal plane.
		do
			-- fixme rotate!
			draw_text_top_left (x, y, a_text)
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			-- fixme make ellipsed
			draw_text_top_left (x, y, a_text)
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			-- fixme make ellipsed
			draw_text_top_left (x, y, a_text)
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING_GENERAL)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		local
			l_string: NS_STRING
			l_attributes: NS_DICTIONARY
			l_font: EV_FONT_IMP
		do
			create l_string.make_with_string (a_text)
			l_font ?= font.implementation
			create l_attributes.make_with_object_for_key (l_font.font, l_font.font.font_attribute_name)
			image.lock_focus
			l_string.draw_at_point_with_attributes (create {NS_POINT}.make_point (x, y), l_attributes)
			image.unlock_focus
			update_if_needed
		end

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw line segment from (`x1', `y1') to (`x2', `y2').
		local
			path: NS_BEZIER_PATH
		do
			prepare_drawing
			create path.make
			path.set_line_width (internal_line_width)
			if internal_dashed_line_style then
				path.set_line_dash_count_phase (create {ARRAYED_LIST[REAL]}.make_from_array (<<1.0, 1.0>>), 0.0)
			end
			path.move_to_point (create {NS_POINT}.make_point (x1, y1))
			path.line_to_point (create {NS_POINT}.make_point (x2, y2))
			path.stroke
			image.unlock_focus
			update_if_needed
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		do
		end

	draw_sub_pixel_buffer (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixel_buffer' with upper-left corner on (`a_x', `a_y').
		do
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			prepare_drawing
			pixmap_imp ?= a_pixmap.implementation
			pixmap_imp.image.draw_at_point_from_rect_operation_fraction (
				create {NS_POINT}.make_point (x, y),
				create {NS_RECT}.make_rect (0, 0, a_pixmap.width, a_pixmap.height),
				{NS_IMAGE}.composite_source_over, 1)
			image.unlock_focus
			update_if_needed
		end

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP
			-- Pixmap region of `Current' represented by rectangle `area'
		do
			-- TODO
			create Result
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			prepare_drawing
			pixmap_imp ?= a_pixmap.implementation
			pixmap_imp.image.draw_at_point_from_rect_operation_fraction (
				create {NS_POINT}.make_point (x, y),
				create {NS_RECT}.make_rect (0, 0, area.width, area.height),
				{NS_IMAGE}.composite_source_over, 1)
			image.unlock_focus
			update_if_needed
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		local
			path: NS_BEZIER_PATH
		do
			prepare_drawing
			create path.make_with_rect ( create {NS_RECT}.make_rect (x, y, a_width, a_height) )
			path.set_line_width (internal_line_width)
			if internal_dashed_line_style then
				path.set_line_dash_count_phase (create {ARRAYED_LIST[REAL]}.make_from_array (<<1.0, 1.0>>), 0.0)
			end
			path.stroke
			image.unlock_focus
			update_if_needed
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		local
			path: NS_BEZIER_PATH
		do
			prepare_drawing
			create path.make_with_oval_in_rect ( create {NS_RECT}.make_rect (x, y, a_width, a_height) )
			path.set_line_width (internal_line_width)
			if internal_dashed_line_style then
				path.set_line_dash_count_phase (create {ARRAYED_LIST[REAL]}.make_from_array (<<1.0, 1.0>>), 0.0)
			end
			path.stroke
			image.unlock_focus
			update_if_needed
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			path: NS_BEZIER_PATH
			i: INTEGER
			l_point: EV_COORDINATE
		do
			prepare_drawing
			create path.make
			path.set_line_width (internal_line_width)
			if internal_dashed_line_style then
				path.set_line_dash_count_phase (create {ARRAYED_LIST[REAL]}.make_from_array (<<1.0, 1.0>>), 0.0)
			end
			if not points.is_empty then
				l_point := 	points.item (points.lower)
				path.move_to_point (create {NS_POINT}.make_point (l_point.x, l_point.y))
				from
					i := points.lower + 1
				until
					i > points.upper
				loop
					l_point := 	points.item (i)
					path.line_to_point (create {NS_POINT}.make_point (l_point.x, l_point.y))
					i := i + 1
				end
				if is_closed then
					l_point := 	points.item (points.lower)
					path.line_to_point (create {NS_POINT}.make_point (l_point.x, l_point.y))
				end
			end
			path.stroke
			image.unlock_focus
			update_if_needed
		end

	draw_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians
		do

		end

feature -- filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		local
			path: NS_BEZIER_PATH
		do
			prepare_drawing
			create path.make_with_rect ( create {NS_RECT}.make_rect (x, y, a_width, a_height) )
			path.fill
			image.unlock_focus
			update_if_needed
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
		local
			path: NS_BEZIER_PATH
		do
			prepare_drawing
			create path.make_with_oval_in_rect ( create {NS_RECT}.make_rect (x, y, a_width, a_height) )
			path.fill
			image.unlock_focus
			update_if_needed
		end

	fill_polygon (points: ARRAY [EV_COORDINATE])
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		local
			path: NS_BEZIER_PATH
			i: INTEGER
			l_point: EV_COORDINATE
		do
			prepare_drawing
			create path.make
			if not points.is_empty then
				l_point := 	points.item (points.lower)
				path.move_to_point (create {NS_POINT}.make_point (l_point.x, l_point.y))
				from
					i := points.lower + 1
				until
					i > points.upper
				loop
					l_point := 	points.item (i)
					path.line_to_point (create {NS_POINT}.make_point (l_point.x, l_point.y))
					i := i + 1
				end
				l_point := 	points.item (points.lower)
				path.line_to_point (create {NS_POINT}.make_point (l_point.x, l_point.y))
			end
			path.fill
			image.unlock_focus
			update_if_needed
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
		end

feature {EV_ANY_I} -- Implementation

	image: NS_IMAGE

feature {NONE} -- Implementation

	prepare_drawing
		local
			l_color: EV_COLOR_IMP
		do
			image.lock_focus
			l_color ?= foreground_color.implementation
			l_color.color.set
		end

	internal_line_width: INTEGER

	internal_dashed_line_style: BOOLEAN

	internal_foreground_color: EV_COLOR
			-- Color used to draw primitives.

	internal_background_color: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.

	flush
			-- Force all queued expose events to be called.
		deferred
		end

	update_if_needed
			-- Force update of `Current' if needed
		deferred
		end

	internal_font_imp: EV_FONT_IMP

	interface: EV_DRAWABLE;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_DRAWABLE_IMP
