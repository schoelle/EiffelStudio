indexing

	description:
		"Data panel used for capturing system tool parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end
	EB_SYSTEM_TOOL_DATA
		rename
			System_resources as parameters
		export
			{NONE} all
		end
	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
			--
		do
			Precursor (par, a_tool)

			create tool_width.make_with_resource (Current, parameters.tool_width)
			create tool_height.make_with_resource (Current, parameters.tool_height)
			create command_bar.make_with_resource (Current, parameters.command_bar)
			create parse_ace_after_saving.make_with_resource (Current, parameters.parse_ace_after_saving)
			--create arr_hidden_clusters.make (parameters.hidden_clusters)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (command_bar)
			resources.extend (parse_ace_after_saving)
			--resources.extend (arr_hidden_clusters)

		end

feature -- Access

	name: STRING is "System tool preferences"
			-- Current's name

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_System
		end

feature {NONE} -- Implementation

	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	command_bar, parse_ace_after_saving: EB_BOOLEAN_RESOURCE_DISPLAY
	--arr_hidden_clusters: EB_ARRAY_RESOURCE_DISPLAY

end -- class EB_SYSTEM_ENTRY_PANEL
