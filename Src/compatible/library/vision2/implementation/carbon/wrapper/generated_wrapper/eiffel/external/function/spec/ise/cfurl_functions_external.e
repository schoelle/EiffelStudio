-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- functions wrapper
class CFURL_FUNCTIONS_EXTERNAL

feature
	frozen cfurlget_type_id_external: INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] :CFTypeID"
		alias
			"ewg_function_macro_CFURLGetTypeID"
		end

	frozen cfurlget_type_id_address_external: POINTER is
			-- Address of C function `CFURLGetTypeID'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetTypeID"
		end

	frozen cfurlcreate_with_bytes_external (allocator: POINTER; urlbytes: POINTER; length: INTEGER; encoding: INTEGER; baseurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, UInt8 const*, CFIndex, CFStringEncoding, CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateWithBytes"
		end

	frozen cfurlcreate_with_bytes_address_external: POINTER is
			-- Address of C function `CFURLCreateWithBytes'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateWithBytes"
		end

	frozen cfurlcreate_data_external (allocator: POINTER; url: POINTER; encoding: INTEGER; escapewhitespace: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFURLRef, CFStringEncoding, Boolean):CFDataRef"
		alias
			"ewg_function_macro_CFURLCreateData"
		end

	frozen cfurlcreate_data_address_external: POINTER is
			-- Address of C function `CFURLCreateData'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateData"
		end

	frozen cfurlcreate_with_string_external (allocator: POINTER; urlstring: POINTER; baseurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFStringRef, CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateWithString"
		end

	frozen cfurlcreate_with_string_address_external: POINTER is
			-- Address of C function `CFURLCreateWithString'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateWithString"
		end

	frozen cfurlcreate_absolute_urlwith_bytes_external (alloc: POINTER; relativeurlbytes: POINTER; length: INTEGER; encoding: INTEGER; baseurl: POINTER; usecompatibilitymode: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, UInt8 const*, CFIndex, CFStringEncoding, CFURLRef, Boolean):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateAbsoluteURLWithBytes"
		end

	frozen cfurlcreate_absolute_urlwith_bytes_address_external: POINTER is
			-- Address of C function `CFURLCreateAbsoluteURLWithBytes'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateAbsoluteURLWithBytes"
		end

	frozen cfurlcreate_with_file_system_path_external (allocator: POINTER; filepath: POINTER; pathstyle: INTEGER; isdirectory: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateWithFileSystemPath"
		end

	frozen cfurlcreate_with_file_system_path_address_external: POINTER is
			-- Address of C function `CFURLCreateWithFileSystemPath'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateWithFileSystemPath"
		end

	frozen cfurlcreate_from_file_system_representation_external (allocator: POINTER; buffer: POINTER; buflen: INTEGER; isdirectory: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, UInt8 const*, CFIndex, Boolean):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateFromFileSystemRepresentation"
		end

	frozen cfurlcreate_from_file_system_representation_address_external: POINTER is
			-- Address of C function `CFURLCreateFromFileSystemRepresentation'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateFromFileSystemRepresentation"
		end

	frozen cfurlcreate_with_file_system_path_relative_to_base_external (allocator: POINTER; filepath: POINTER; pathstyle: INTEGER; isdirectory: INTEGER; baseurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean, CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateWithFileSystemPathRelativeToBase"
		end

	frozen cfurlcreate_with_file_system_path_relative_to_base_address_external: POINTER is
			-- Address of C function `CFURLCreateWithFileSystemPathRelativeToBase'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateWithFileSystemPathRelativeToBase"
		end

	frozen cfurlcreate_from_file_system_representation_relative_to_base_external (allocator: POINTER; buffer: POINTER; buflen: INTEGER; isdirectory: INTEGER; baseurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, UInt8 const*, CFIndex, Boolean, CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateFromFileSystemRepresentationRelativeToBase"
		end

	frozen cfurlcreate_from_file_system_representation_relative_to_base_address_external: POINTER is
			-- Address of C function `CFURLCreateFromFileSystemRepresentationRelativeToBase'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateFromFileSystemRepresentationRelativeToBase"
		end

	frozen cfurlget_file_system_representation_external (url: POINTER; resolveagainstbase: INTEGER; buffer: POINTER; maxbuflen: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, Boolean, UInt8*, CFIndex):Boolean"
		alias
			"ewg_function_macro_CFURLGetFileSystemRepresentation"
		end

	frozen cfurlget_file_system_representation_address_external: POINTER is
			-- Address of C function `CFURLGetFileSystemRepresentation'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetFileSystemRepresentation"
		end

	frozen cfurlcopy_absolute_url_external (relativeurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCopyAbsoluteURL"
		end

	frozen cfurlcopy_absolute_url_address_external: POINTER is
			-- Address of C function `CFURLCopyAbsoluteURL'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyAbsoluteURL"
		end

	frozen cfurlget_string_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLGetString"
		end

	frozen cfurlget_string_address_external: POINTER is
			-- Address of C function `CFURLGetString'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetString"
		end

	frozen cfurlget_base_url_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLGetBaseURL"
		end

	frozen cfurlget_base_url_address_external: POINTER is
			-- Address of C function `CFURLGetBaseURL'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetBaseURL"
		end

	frozen cfurlcan_be_decomposed_external (anurl: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):Boolean"
		alias
			"ewg_function_macro_CFURLCanBeDecomposed"
		end

	frozen cfurlcan_be_decomposed_address_external: POINTER is
			-- Address of C function `CFURLCanBeDecomposed'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCanBeDecomposed"
		end

	frozen cfurlcopy_scheme_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyScheme"
		end

	frozen cfurlcopy_scheme_address_external: POINTER is
			-- Address of C function `CFURLCopyScheme'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyScheme"
		end

	frozen cfurlcopy_net_location_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyNetLocation"
		end

	frozen cfurlcopy_net_location_address_external: POINTER is
			-- Address of C function `CFURLCopyNetLocation'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyNetLocation"
		end

	frozen cfurlcopy_path_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyPath"
		end

	frozen cfurlcopy_path_address_external: POINTER is
			-- Address of C function `CFURLCopyPath'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyPath"
		end

	frozen cfurlcopy_strict_path_external (anurl: POINTER; isabsolute: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, Boolean*):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyStrictPath"
		end

	frozen cfurlcopy_strict_path_address_external: POINTER is
			-- Address of C function `CFURLCopyStrictPath'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyStrictPath"
		end

	frozen cfurlcopy_file_system_path_external (anurl: POINTER; pathstyle: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, CFURLPathStyle):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyFileSystemPath"
		end

	frozen cfurlcopy_file_system_path_address_external: POINTER is
			-- Address of C function `CFURLCopyFileSystemPath'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyFileSystemPath"
		end

	frozen cfurlhas_directory_path_external (anurl: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):Boolean"
		alias
			"ewg_function_macro_CFURLHasDirectoryPath"
		end

	frozen cfurlhas_directory_path_address_external: POINTER is
			-- Address of C function `CFURLHasDirectoryPath'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLHasDirectoryPath"
		end

	frozen cfurlcopy_resource_specifier_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyResourceSpecifier"
		end

	frozen cfurlcopy_resource_specifier_address_external: POINTER is
			-- Address of C function `CFURLCopyResourceSpecifier'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyResourceSpecifier"
		end

	frozen cfurlcopy_host_name_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyHostName"
		end

	frozen cfurlcopy_host_name_address_external: POINTER is
			-- Address of C function `CFURLCopyHostName'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyHostName"
		end

	frozen cfurlget_port_number_external (anurl: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):SInt32"
		alias
			"ewg_function_macro_CFURLGetPortNumber"
		end

	frozen cfurlget_port_number_address_external: POINTER is
			-- Address of C function `CFURLGetPortNumber'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetPortNumber"
		end

	frozen cfurlcopy_user_name_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyUserName"
		end

	frozen cfurlcopy_user_name_address_external: POINTER is
			-- Address of C function `CFURLCopyUserName'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyUserName"
		end

	frozen cfurlcopy_password_external (anurl: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyPassword"
		end

	frozen cfurlcopy_password_address_external: POINTER is
			-- Address of C function `CFURLCopyPassword'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyPassword"
		end

	frozen cfurlcopy_parameter_string_external (anurl: POINTER; characterstoleaveescaped: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, CFStringRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyParameterString"
		end

	frozen cfurlcopy_parameter_string_address_external: POINTER is
			-- Address of C function `CFURLCopyParameterString'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyParameterString"
		end

	frozen cfurlcopy_query_string_external (anurl: POINTER; characterstoleaveescaped: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, CFStringRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyQueryString"
		end

	frozen cfurlcopy_query_string_address_external: POINTER is
			-- Address of C function `CFURLCopyQueryString'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyQueryString"
		end

	frozen cfurlcopy_fragment_external (anurl: POINTER; characterstoleaveescaped: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, CFStringRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyFragment"
		end

	frozen cfurlcopy_fragment_address_external: POINTER is
			-- Address of C function `CFURLCopyFragment'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyFragment"
		end

	frozen cfurlcopy_last_path_component_external (url: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyLastPathComponent"
		end

	frozen cfurlcopy_last_path_component_address_external: POINTER is
			-- Address of C function `CFURLCopyLastPathComponent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyLastPathComponent"
		end

	frozen cfurlcopy_path_extension_external (url: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCopyPathExtension"
		end

	frozen cfurlcopy_path_extension_address_external: POINTER is
			-- Address of C function `CFURLCopyPathExtension'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCopyPathExtension"
		end

	frozen cfurlcreate_copy_appending_path_component_external (allocator: POINTER; url: POINTER; pathcomponent: POINTER; isdirectory: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFURLRef, CFStringRef, Boolean):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateCopyAppendingPathComponent"
		end

	frozen cfurlcreate_copy_appending_path_component_address_external: POINTER is
			-- Address of C function `CFURLCreateCopyAppendingPathComponent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateCopyAppendingPathComponent"
		end

	frozen cfurlcreate_copy_deleting_last_path_component_external (allocator: POINTER; url: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateCopyDeletingLastPathComponent"
		end

	frozen cfurlcreate_copy_deleting_last_path_component_address_external: POINTER is
			-- Address of C function `CFURLCreateCopyDeletingLastPathComponent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateCopyDeletingLastPathComponent"
		end

	frozen cfurlcreate_copy_appending_path_extension_external (allocator: POINTER; url: POINTER; extension: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFURLRef, CFStringRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateCopyAppendingPathExtension"
		end

	frozen cfurlcreate_copy_appending_path_extension_address_external: POINTER is
			-- Address of C function `CFURLCreateCopyAppendingPathExtension'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateCopyAppendingPathExtension"
		end

	frozen cfurlcreate_copy_deleting_path_extension_external (allocator: POINTER; url: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFURLRef):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateCopyDeletingPathExtension"
		end

	frozen cfurlcreate_copy_deleting_path_extension_address_external: POINTER is
			-- Address of C function `CFURLCreateCopyDeletingPathExtension'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateCopyDeletingPathExtension"
		end

	frozen cfurlget_bytes_external (url: POINTER; buffer: POINTER; bufferlength: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, UInt8*, CFIndex):CFIndex"
		alias
			"ewg_function_macro_CFURLGetBytes"
		end

	frozen cfurlget_bytes_address_external: POINTER is
			-- Address of C function `CFURLGetBytes'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetBytes"
		end

	frozen cfurlget_byte_range_for_component_external (url: POINTER; component: INTEGER; rangeincludingseparators: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, CFURLComponentType, CFRange*):CFRange*"
		alias
			"ewg_function_CFURLGetByteRangeForComponent"
		end

	frozen cfurlget_byte_range_for_component_address_external: POINTER is
			-- Address of C function `CFURLGetByteRangeForComponent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetByteRangeForComponent"
		end

	frozen cfurlcreate_string_by_replacing_percent_escapes_external (allocator: POINTER; originalstring: POINTER; characterstoleaveescaped: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFStringRef, CFStringRef):CFStringRef"
		alias
			"ewg_function_macro_CFURLCreateStringByReplacingPercentEscapes"
		end

	frozen cfurlcreate_string_by_replacing_percent_escapes_address_external: POINTER is
			-- Address of C function `CFURLCreateStringByReplacingPercentEscapes'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateStringByReplacingPercentEscapes"
		end

	frozen cfurlcreate_string_by_replacing_percent_escapes_using_encoding_external (allocator: POINTER; origstring: POINTER; charstoleaveescaped: POINTER; encoding: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFStringRef, CFStringRef, CFStringEncoding):CFStringRef"
		alias
			"ewg_function_macro_CFURLCreateStringByReplacingPercentEscapesUsingEncoding"
		end

	frozen cfurlcreate_string_by_replacing_percent_escapes_using_encoding_address_external: POINTER is
			-- Address of C function `CFURLCreateStringByReplacingPercentEscapesUsingEncoding'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateStringByReplacingPercentEscapesUsingEncoding"
		end

	frozen cfurlcreate_string_by_adding_percent_escapes_external (allocator: POINTER; originalstring: POINTER; characterstoleaveunescaped: POINTER; legalurlcharacterstobeescaped: POINTER; encoding: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, CFStringEncoding):CFStringRef"
		alias
			"ewg_function_macro_CFURLCreateStringByAddingPercentEscapes"
		end

	frozen cfurlcreate_string_by_adding_percent_escapes_address_external: POINTER is
			-- Address of C function `CFURLCreateStringByAddingPercentEscapes'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateStringByAddingPercentEscapes"
		end

	frozen cfurlcreate_from_fsref_external (allocator: POINTER; fsref: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, struct FSRef const*):CFURLRef"
		alias
			"ewg_function_macro_CFURLCreateFromFSRef"
		end

	frozen cfurlcreate_from_fsref_address_external: POINTER is
			-- Address of C function `CFURLCreateFromFSRef'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLCreateFromFSRef"
		end

	frozen cfurlget_fsref_external (url: POINTER; fsref: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFURLRef, struct FSRef*):Boolean"
		alias
			"ewg_function_macro_CFURLGetFSRef"
		end

	frozen cfurlget_fsref_address_external: POINTER is
			-- Address of C function `CFURLGetFSRef'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFURLGetFSRef"
		end

end