/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record _tagRemBINDINFO
	cbSize: ULONG
			-- No description available.
	szExtraInfo: LPWSTR
			-- No description available.
	grfBindInfoF: ULONG
			-- No description available.
	dwBindVerb: ULONG
			-- No description available.
	szCustomVerb: LPWSTR
			-- No description available.
	cbstgmedData: ULONG
			-- No description available.
	dwOptions: ULONG
			-- No description available.
	dwOptionsFlags: ULONG
			-- No description available.
	dwCodePage: ULONG
			-- No description available.
	securityAttributes: typedef
			-- No description available.
	iid: typedef
			-- No description available.
	punk: IUnknown *
			-- No description available.
	dwReserved: ULONG
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY__TAGREMBINDINFO_S_H__
#define __ECOM_CONTROL_LIBRARY__TAGREMBINDINFO_S_H__
#ifdef __cplusplus
extern "C" {
#endif


namespace ecom_control_library
{
struct tag_tagRemBINDINFO;
typedef struct ecom_control_library::tag_tagRemBINDINFO _tagRemBINDINFO;
}

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__REMSECURITY_ATTRIBUTES_s.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library
{
struct tag_tagRemBINDINFO
{	ULONG cbSize;
	LPWSTR szExtraInfo;
	ULONG grfBindInfoF;
	ULONG dwBindVerb;
	LPWSTR szCustomVerb;
	ULONG cbstgmedData;
	ULONG dwOptions;
	ULONG dwOptionsFlags;
	ULONG dwCodePage;
	ecom_control_library::_REMSECURITY_ATTRIBUTES securityAttributes;
	GUID iid;
	IUnknown * punk;
	ULONG dwReserved;
};
}
#ifdef __cplusplus
}
#endif

#endif