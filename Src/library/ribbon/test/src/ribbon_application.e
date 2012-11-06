note
	description: "[
					Objects that represent the Ribbon Vision2 application.%
					%The original version of this class has been generated by EiffelRibbon
								]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision: 87361 $"

class
	RIBBON_APPLICATION

inherit
	MEMORY

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_app: EV_APPLICATION
		do
			create l_app
			application := l_app
			create_interface_objects
			create_and_show_windows
			l_app.add_idle_action_kamikaze (agent check_leaks_and_quit)
			l_app.uncaught_exception_actions.extend (agent record_exception)
			l_app.launch

			report_vision2_failure
		end

feature {NONE} -- Implementation

	check_leaks_and_quit
			-- Check leaks
		do
			full_collect

			application.add_idle_action_kamikaze (agent application.destroy)

			ensure_remaining_one_object_of_type (({detachable RIBBON_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable MAIN_WINDOW}).type_id)
			ensure_remaining_one_object_of_type (({detachable TAB_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable BUTTON_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable BUTTON_2}).type_id)
			ensure_remaining_one_object_of_type (({detachable GROUP_1}).type_id)
			ensure_remaining_one_object_of_type (({detachable EV_RIBBON_TITLED_WINDOW_IMP}).type_id)
		end

	ensure_remaining_one_object_of_type (a_type: INTEGER)
			-- Ensure that only one object of `a_type' is left in the system
			-- Otherwise raise an exception
		local
			l_list: detachable ARRAYED_LIST [ANY]
		do
			l_list := memory_map.item (a_type)
			if l_list /= Void then
				if l_list.count /= 1 then
						-- Only one object is left
					(create {DEVELOPER_EXCEPTION}).raise
				end
			else
				(create {DEVELOPER_EXCEPTION}).raise
			end
		end

	create_interface_objects
			-- <Precursor>
		do
			create main_window
		end

	create_and_show_windows
		local
			l_main_window: MAIN_WINDOW
		do
			main_window.set_title ("Do not close me, close the other one.")
			main_window.show

			create l_main_window
			l_main_window.show
			l_main_window.destroy

				-- Location of memory analyzer library.
--			create m.make ("C:\work\72dev\library\memory_analyzer")
--			m.show
		end

	main_window: MAIN_WINDOW

	application: EV_APPLICATION

--	m: detachable MA_WINDOW

feature -- Exception

	record_exception (a_exception: EXCEPTION)
			-- Record vision2 exception
		do
			if first_recorded_exception = Void then
				first_recorded_exception := a_exception
			end
		end

	report_vision2_failure
			-- Report failure in vision2
		do
			if attached first_recorded_exception as l_exception then
				l_exception.raise
			end
		end

	first_recorded_exception: detachable EXCEPTION
			-- The first recored exception in Vision2 message loop

end

