/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record EXCEPINFO
	wCode: USHORT
			-- No description available.
	wReserved: USHORT
			-- No description available.
	bstrSource: BSTR
			-- No description available.
	bstrDescription: BSTR
			-- No description available.
	bstrHelpFile: BSTR
			-- No description available.
	dwHelpContext: ULONG
			-- No description available.
	pvReserved: Pointed Type
			-- No description available.
	pfnDeferredFillIn: Pointed Type
			-- No description available.
	scode: HRESULT
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_EXCEPINFO_H__
#define __ECOM_EXCEPINFO_H__


#include "eif_com.h"

#include "eif_eiffel.h"


#include "ecom_rt_globals.h"

#ifdef __cplusplus

#define ccom_excepinfo_w_code(_ptr_) (EIF_INTEGER)(USHORT)(((EXCEPINFO *)_ptr_)->wCode)

#define ccom_excepinfo_set_w_code(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->wCode) = (USHORT)_field_)

#define ccom_excepinfo_w_reserved(_ptr_) (EIF_INTEGER)(USHORT)(((EXCEPINFO *)_ptr_)->wReserved)

#define ccom_excepinfo_set_w_reserved(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->wReserved) = (USHORT)_field_)

#define ccom_excepinfo_bstr_source(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_bstr (((EXCEPINFO *)_ptr_)->bstrSource))

#define ccom_excepinfo_set_bstr_source(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->bstrSource) = rt_ec.ccom_ec_bstr (eif_access (_field_)))

#define ccom_excepinfo_bstr_description(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_bstr (((EXCEPINFO *)_ptr_)->bstrDescription))

#define ccom_excepinfo_set_bstr_description(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->bstrDescription) = rt_ec.ccom_ec_bstr (eif_access (_field_)))

#define ccom_excepinfo_bstr_help_file(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_bstr (((EXCEPINFO *)_ptr_)->bstrHelpFile))

#define ccom_excepinfo_set_bstr_help_file(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->bstrHelpFile) = rt_ec.ccom_ec_bstr (eif_access (_field_)))

#define ccom_excepinfo_dw_help_context(_ptr_) (EIF_INTEGER)(ULONG)(((EXCEPINFO *)_ptr_)->dwHelpContext)

#define ccom_excepinfo_set_dw_help_context(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->dwHelpContext) = (ULONG)_field_)

#define ccom_excepinfo_pv_reserved(_ptr_) (EIF_POINTER)(void *)(((EXCEPINFO *)_ptr_)->pvReserved)

#define ccom_excepinfo_set_pv_reserved(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->pvReserved) = (void *)_field_)

#define ccom_excepinfo_pfn_deferred_fill_in(_ptr_) (EIF_POINTER)(void *)(((EXCEPINFO *)_ptr_)->pfnDeferredFillIn)

#define ccom_excepinfo_set_pfn_deferred_fill_in(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->pfnDeferredFillIn) = (void *)_field_)

#define ccom_excepinfo_scode(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_hresult (((EXCEPINFO *)_ptr_)->scode))

#define ccom_excepinfo_set_scode(_ptr_, _field_) ((((EXCEPINFO *)_ptr_)->scode) = rt_ec.ccom_ec_hresult (eif_access (_field_)))

#endif

#endif