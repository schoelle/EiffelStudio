note
	description: "[
					This class is generated by EiffelRibbon Tool
					Don't modify it manually, since it would be generated again
																					]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON

inherit
	EV_ANY_HANDLER

feature -- Command

	init_with_window (a_window: EV_WINDOW)
			-- Creation method
		local
			l_result: INTEGER
		do
			if attached {EV_WINDOW_IMP} a_window.implementation as l_imp then
				com_initialize
				l_result := create_ribbon_com_framework (l_imp.wel_item)
			end
		end

	destroy
			-- Clean up all ribbon related COM objects and resources
		do
			destroy_ribbon_com_framwork
			com_uninitialize
		end

feature -- Query

	tabs: ARRAYED_LIST [EV_RIBBON_TAB]
			-- All tabs in current tool bar

	height: INTEGER
			-- Get current ribbon height
		do
			get_height ($Result)
		end

feature {EV_RIBBON_TITLED_WINDOW_IMP} -- Externals

	com_initialize
			-- Initialize COM
		external
			"C inline use %"Objbase.h%""
		alias
			"[
			{
			
				CoInitialize (0);
			}
			]"
		end

	com_uninitialize
			-- Clean up COM resources
		external
			"C inline use %"Objbase.h%""
		alias
			"[
			{
				CoUninitialize();
			}
			]"
		end

	create_ribbon_com_framework (a_hwnd: POINTER): INTEGER
			-- Create Ribbon framework, attach ribbon to `a_hwnd'
		external
			"C inline use <ribbon.h>"
		alias
			"[
			{
				return InitializeFramework ($a_hwnd);
			}
			]"
		end

	destroy_ribbon_com_framwork
			-- Destroy ribbon framwork
		external
			"C inline use <ribbon.h>"
		alias
			"[
			{
				DestroyRibbon ();
			}
			]"
		end

	get_height (a_height: TYPED_POINTER[INTEGER])
			-- Get ribbon height
		external
			"C inline use <ribbon.h>"
		alias
			"[
			{
				GetRibbonHeight ($a_height);	
			}
			]"
		end

	set_modes (a_mode: INTEGER)
			-- Set application mode
		external
			"C inline use <ribbon.h>"
		alias
			"[
			{
				SetModes ($a_mode);
			}
			]"
		end

end

