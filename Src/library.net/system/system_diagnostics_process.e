indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.Process"

external class
	SYSTEM_DIAGNOSTICS_PROCESS

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose,
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_process

feature {NONE} -- Initialization

	frozen make_process is
		external
			"IL creator use System.Diagnostics.Process"
		end

feature -- Access

	frozen get_virtual_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_VirtualMemorySize"
		end

	frozen get_min_working_set: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.Process"
		alias
			"get_MinWorkingSet"
		end

	frozen get_working_set: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_WorkingSet"
		end

	frozen get_priority_class: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL signature (): System.Diagnostics.ProcessPriorityClass use System.Diagnostics.Process"
		alias
			"get_PriorityClass"
		end

	frozen get_paged_system_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_PagedSystemMemorySize"
		end

	frozen get_main_module: SYSTEM_DIAGNOSTICS_PROCESSMODULE is
		external
			"IL signature (): System.Diagnostics.ProcessModule use System.Diagnostics.Process"
		alias
			"get_MainModule"
		end

	frozen get_user_processor_time: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.Diagnostics.Process"
		alias
			"get_UserProcessorTime"
		end

	frozen get_process_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.Process"
		alias
			"get_ProcessName"
		end

	frozen get_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_Id"
		end

	frozen get_standard_error: SYSTEM_IO_STREAMREADER is
		external
			"IL signature (): System.IO.StreamReader use System.Diagnostics.Process"
		alias
			"get_StandardError"
		end

	frozen get_start_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.Process"
		alias
			"get_StartTime"
		end

	frozen get_main_window_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.Process"
		alias
			"get_MainWindowHandle"
		end

	frozen get_priority_boost_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"get_PriorityBoostEnabled"
		end

	frozen get_exit_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.Process"
		alias
			"get_ExitTime"
		end

	frozen get_peak_working_set: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_PeakWorkingSet"
		end

	frozen get_enable_raising_events: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"get_EnableRaisingEvents"
		end

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.Process"
		alias
			"get_MachineName"
		end

	frozen get_standard_output: SYSTEM_IO_STREAMREADER is
		external
			"IL signature (): System.IO.StreamReader use System.Diagnostics.Process"
		alias
			"get_StandardOutput"
		end

	frozen get_threads: SYSTEM_DIAGNOSTICS_PROCESSTHREADCOLLECTION is
		external
			"IL signature (): System.Diagnostics.ProcessThreadCollection use System.Diagnostics.Process"
		alias
			"get_Threads"
		end

	frozen get_main_window_title: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.Process"
		alias
			"get_MainWindowTitle"
		end

	frozen get_standard_input: SYSTEM_IO_STREAMWRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.Diagnostics.Process"
		alias
			"get_StandardInput"
		end

	frozen get_synchronizing_object: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE is
		external
			"IL signature (): System.ComponentModel.ISynchronizeInvoke use System.Diagnostics.Process"
		alias
			"get_SynchronizingObject"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.Process"
		alias
			"get_Handle"
		end

	frozen get_start_info: SYSTEM_DIAGNOSTICS_PROCESSSTARTINFO is
		external
			"IL signature (): System.Diagnostics.ProcessStartInfo use System.Diagnostics.Process"
		alias
			"get_StartInfo"
		end

	frozen get_handle_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_HandleCount"
		end

	frozen get_exit_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_ExitCode"
		end

	frozen get_modules: SYSTEM_DIAGNOSTICS_PROCESSMODULECOLLECTION is
		external
			"IL signature (): System.Diagnostics.ProcessModuleCollection use System.Diagnostics.Process"
		alias
			"get_Modules"
		end

	frozen get_base_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_BasePriority"
		end

	frozen get_privileged_processor_time: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.Diagnostics.Process"
		alias
			"get_PrivilegedProcessorTime"
		end

	frozen get_max_working_set: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.Process"
		alias
			"get_MaxWorkingSet"
		end

	frozen get_private_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_PrivateMemorySize"
		end

	frozen get_has_exited: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"get_HasExited"
		end

	frozen get_processor_affinity: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.Process"
		alias
			"get_ProcessorAffinity"
		end

	frozen get_nonpaged_system_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_NonpagedSystemMemorySize"
		end

	frozen get_responding: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"get_Responding"
		end

	frozen get_total_processor_time: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.Diagnostics.Process"
		alias
			"get_TotalProcessorTime"
		end

	frozen get_peak_paged_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_PeakPagedMemorySize"
		end

	frozen get_paged_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_PagedMemorySize"
		end

	frozen get_peak_virtual_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Process"
		alias
			"get_PeakVirtualMemorySize"
		end

feature -- Element Change

	frozen set_priority_class (value: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS) is
		external
			"IL signature (System.Diagnostics.ProcessPriorityClass): System.Void use System.Diagnostics.Process"
		alias
			"set_PriorityClass"
		end

	frozen set_max_working_set (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Diagnostics.Process"
		alias
			"set_MaxWorkingSet"
		end

	frozen set_priority_boost_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.Process"
		alias
			"set_PriorityBoostEnabled"
		end

	frozen set_synchronizing_object (value: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.Diagnostics.Process"
		alias
			"set_SynchronizingObject"
		end

	frozen set_min_working_set (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Diagnostics.Process"
		alias
			"set_MinWorkingSet"
		end

	frozen set_processor_affinity (value: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Diagnostics.Process"
		alias
			"set_ProcessorAffinity"
		end

	frozen set_enable_raising_events (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.Process"
		alias
			"set_EnableRaisingEvents"
		end

	frozen set_start_info (value: SYSTEM_DIAGNOSTICS_PROCESSSTARTINFO) is
		external
			"IL signature (System.Diagnostics.ProcessStartInfo): System.Void use System.Diagnostics.Process"
		alias
			"set_StartInfo"
		end

	frozen remove_exited (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Diagnostics.Process"
		alias
			"remove_Exited"
		end

	frozen add_exited (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Diagnostics.Process"
		alias
			"add_Exited"
		end

feature -- Basic Operations

	frozen start: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"Start"
		end

	frozen wait_for_input_idle: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"WaitForInputIdle"
		end

	frozen get_current_process: SYSTEM_DIAGNOSTICS_PROCESS is
		external
			"IL static signature (): System.Diagnostics.Process use System.Diagnostics.Process"
		alias
			"GetCurrentProcess"
		end

	frozen get_process_by_id_int32_string (process_id: INTEGER; machine_name: STRING): SYSTEM_DIAGNOSTICS_PROCESS is
		external
			"IL static signature (System.Int32, System.String): System.Diagnostics.Process use System.Diagnostics.Process"
		alias
			"GetProcessById"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Diagnostics.Process"
		alias
			"Close"
		end

	frozen start_string (file_name: STRING): SYSTEM_DIAGNOSTICS_PROCESS is
		external
			"IL static signature (System.String): System.Diagnostics.Process use System.Diagnostics.Process"
		alias
			"Start"
		end

	frozen wait_for_input_idle_int32 (milliseconds: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Diagnostics.Process"
		alias
			"WaitForInputIdle"
		end

	frozen enter_debug_mode is
		external
			"IL static signature (): System.Void use System.Diagnostics.Process"
		alias
			"EnterDebugMode"
		end

	frozen get_processes_string (machine_name: STRING): ARRAY [SYSTEM_DIAGNOSTICS_PROCESS] is
		external
			"IL static signature (System.String): System.Diagnostics.Process[] use System.Diagnostics.Process"
		alias
			"GetProcesses"
		end

	frozen start_process_start_info (start_info: SYSTEM_DIAGNOSTICS_PROCESSSTARTINFO): SYSTEM_DIAGNOSTICS_PROCESS is
		external
			"IL static signature (System.Diagnostics.ProcessStartInfo): System.Diagnostics.Process use System.Diagnostics.Process"
		alias
			"Start"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Diagnostics.Process"
		alias
			"Dispose"
		end

	frozen get_processes: ARRAY [SYSTEM_DIAGNOSTICS_PROCESS] is
		external
			"IL static signature (): System.Diagnostics.Process[] use System.Diagnostics.Process"
		alias
			"GetProcesses"
		end

	frozen wait_for_exit_int32 (milliseconds: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Diagnostics.Process"
		alias
			"WaitForExit"
		end

	frozen refresh is
		external
			"IL signature (): System.Void use System.Diagnostics.Process"
		alias
			"Refresh"
		end

	frozen get_processes_by_name (process_name: STRING): ARRAY [SYSTEM_DIAGNOSTICS_PROCESS] is
		external
			"IL static signature (System.String): System.Diagnostics.Process[] use System.Diagnostics.Process"
		alias
			"GetProcessesByName"
		end

	frozen get_process_by_id (process_id: INTEGER): SYSTEM_DIAGNOSTICS_PROCESS is
		external
			"IL static signature (System.Int32): System.Diagnostics.Process use System.Diagnostics.Process"
		alias
			"GetProcessById"
		end

	frozen start_string_string (file_name: STRING; arguments: STRING): SYSTEM_DIAGNOSTICS_PROCESS is
		external
			"IL static signature (System.String, System.String): System.Diagnostics.Process use System.Diagnostics.Process"
		alias
			"Start"
		end

	frozen leave_debug_mode is
		external
			"IL static signature (): System.Void use System.Diagnostics.Process"
		alias
			"LeaveDebugMode"
		end

	frozen get_processes_by_name_string_string (process_name: STRING; machine_name: STRING): ARRAY [SYSTEM_DIAGNOSTICS_PROCESS] is
		external
			"IL static signature (System.String, System.String): System.Diagnostics.Process[] use System.Diagnostics.Process"
		alias
			"GetProcessesByName"
		end

	frozen kill is
		external
			"IL signature (): System.Void use System.Diagnostics.Process"
		alias
			"Kill"
		end

	frozen close_main_window: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.Process"
		alias
			"CloseMainWindow"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.Process"
		alias
			"ToString"
		end

	frozen wait_for_exit is
		external
			"IL signature (): System.Void use System.Diagnostics.Process"
		alias
			"WaitForExit"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.Process"
		alias
			"Dispose"
		end

	frozen on_exited is
		external
			"IL signature (): System.Void use System.Diagnostics.Process"
		alias
			"OnExited"
		end

end -- class SYSTEM_DIAGNOSTICS_PROCESS
