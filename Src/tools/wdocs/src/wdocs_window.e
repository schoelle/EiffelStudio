note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	generator: "EiffelBuild"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects, initialize, is_in_default_state
		end

	SHARED_EMBEDED_WEB_SERVICE_INFORMATION
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			default_create
		end

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}

			set_title ("Wiki Docs App")

				-- Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent destroy_and_exit_if_last)

				-- Call `user_initialization'.
			user_initialization
		end

	create_interface_objects
			-- Create objects
		do
			create home_button.make_with_text ("Home")
			create back_button.make_with_text ("Back")
			create forth_button.make_with_text ("Forth")
			create refresh_button.make_with_text ("Refresh")
			create stop_button.make_with_text ("Stop")
			create url_text_field.make_with_text ("http://localhost:" + port_number.out)
			create go_button.make_with_text ("Go")

			create web_browser
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_browser_box: EV_VERTICAL_BOX
			l_server_box: EV_VERTICAL_BOX
			l_hor_box: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
			set_size (800, 600)

			create vb
			extend (vb)
			vb.set_border_width (3)
			vb.set_padding_width (3)

				-- browser part								
			create l_browser_box

			create l_hor_box
			l_browser_box.extend (l_hor_box)
			l_browser_box.disable_item_expand (l_hor_box)

			home_button.select_actions.force_extend (agent on_home_button_action)
			l_hor_box.extend (home_button)
			l_hor_box.disable_item_expand (home_button)

			back_button.select_actions.force_extend (agent on_back_button_action)
			l_hor_box.extend (back_button)
			l_hor_box.disable_item_expand (back_button)

			forth_button.select_actions.force_extend (agent on_forth_button_action)
			l_hor_box.extend (forth_button)
			l_hor_box.disable_item_expand (forth_button)

			refresh_button.select_actions.force_extend (agent on_refresh_button_action)
			l_hor_box.extend (refresh_button)
			l_hor_box.disable_item_expand (refresh_button)

			stop_button.select_actions.force_extend (agent on_stop_button_action)
			l_hor_box.extend (stop_button)
			l_hor_box.disable_item_expand (stop_button)

			l_hor_box.extend (url_text_field)

			go_button.select_actions.force_extend (agent on_go_button_action)
			l_hor_box.extend (go_button)
			l_hor_box.disable_item_expand (go_button)

			l_browser_box.extend (web_browser)

			--------------------
			vb.extend (l_browser_box)
		end

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

feature -- Basic operation

	open_link
		do
			url_text_field.set_text ("http://localhost:" + port_number.out)
			on_go_button_action
		end

feature {NONE} -- Implementation

	home_button, go_button, back_button, forth_button, stop_button, refresh_button: EV_BUTTON
			-- Buttons

	url_text_field: EV_TEXT_FIELD
			-- URL text field

	on_go_button_action
			-- Action for `go_button'
		local
			l_uri: STRING_32
		do
			l_uri := url_text_field.text
			if l_uri /= Void and then not l_uri.is_empty then
				web_browser.load_uri (l_uri)
			else
				on_home_button_action
			end
		end

	on_home_button_action
			-- Action for `home_button'
		do
			web_browser.load_uri ("http://localhost:" + port_number.out)
		end

	on_back_button_action
			-- Action for `back_button'
		do
			web_browser.back
		end

	on_forth_button_action
			-- Action for `forth_button'
		do
			web_browser.forth
		end

	on_refresh_button_action
			-- Action for `refresh_button'
		do
			web_browser.refresh
		end

	on_stop_button_action
			-- Action for `stop_button'
		do
			web_browser.stop
		end

	web_browser: EV_WEB_BROWSER
			-- Web browser widget

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
