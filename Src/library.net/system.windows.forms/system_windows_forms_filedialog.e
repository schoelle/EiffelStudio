indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.FileDialog"

deferred external class
	SYSTEM_WINDOWS_FORMS_FILEDIALOG

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_COMMONDIALOG
		redefine
			hook_proc,
			to_string
		end

feature -- Access

	frozen get_default_ext: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FileDialog"
		alias
			"get_DefaultExt"
		end

	frozen get_dereference_links: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_DereferenceLinks"
		end

	get_check_file_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_CheckFileExists"
		end

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FileDialog"
		alias
			"get_FileName"
		end

	frozen get_add_extension: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_AddExtension"
		end

	frozen get_filter_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.FileDialog"
		alias
			"get_FilterIndex"
		end

	frozen get_title: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FileDialog"
		alias
			"get_Title"
		end

	frozen get_check_path_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_CheckPathExists"
		end

	frozen get_restore_directory: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_RestoreDirectory"
		end

	frozen get_file_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Windows.Forms.FileDialog"
		alias
			"get_FileNames"
		end

	frozen get_filter: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FileDialog"
		alias
			"get_Filter"
		end

	frozen get_validate_names: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_ValidateNames"
		end

	frozen get_show_help: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"get_ShowHelp"
		end

	frozen get_initial_directory: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FileDialog"
		alias
			"get_InitialDirectory"
		end

feature -- Element Change

	frozen add_file_ok (value: SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.FileDialog"
		alias
			"add_FileOk"
		end

	frozen set_show_help (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_ShowHelp"
		end

	frozen set_initial_directory (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_InitialDirectory"
		end

	frozen set_file_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_FileName"
		end

	frozen set_filter_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_FilterIndex"
		end

	frozen set_title (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_Title"
		end

	frozen set_restore_directory (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_RestoreDirectory"
		end

	frozen set_add_extension (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_AddExtension"
		end

	frozen set_check_path_exists (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_CheckPathExists"
		end

	frozen remove_file_ok (value: SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.FileDialog"
		alias
			"remove_FileOk"
		end

	frozen set_dereference_links (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_DereferenceLinks"
		end

	frozen set_validate_names (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_ValidateNames"
		end

	set_check_file_exists (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_CheckFileExists"
		end

	frozen set_filter (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_Filter"
		end

	frozen set_default_ext (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.FileDialog"
		alias
			"set_DefaultExt"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Windows.Forms.FileDialog"
		alias
			"Reset"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FileDialog"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	run_dialog (h_wnd_owner: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use System.Windows.Forms.FileDialog"
		alias
			"RunDialog"
		end

	frozen on_file_ok (e: SYSTEM_COMPONENTMODEL_CANCELEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CancelEventArgs): System.Void use System.Windows.Forms.FileDialog"
		alias
			"OnFileOk"
		end

	hook_proc (h_wnd: POINTER; msg: INTEGER; wparam: POINTER; lparam: POINTER): POINTER is
		external
			"IL signature (System.IntPtr, System.Int32, System.IntPtr, System.IntPtr): System.IntPtr use System.Windows.Forms.FileDialog"
		alias
			"HookProc"
		end

	get_instance: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.FileDialog"
		alias
			"get_Instance"
		end

	frozen get_options: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.FileDialog"
		alias
			"get_Options"
		end

end -- class SYSTEM_WINDOWS_FORMS_FILEDIALOG
