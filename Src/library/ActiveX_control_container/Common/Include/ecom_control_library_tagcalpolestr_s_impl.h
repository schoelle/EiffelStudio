/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagCALPOLESTR
	cElems: ULONG
			-- No description available.
	pElems: Pointed Type
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGCALPOLESTR_S_IMPL_H__
#define __ECOM_CONTROL_LIBRARY_TAGCALPOLESTR_S_IMPL_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagCALPOLESTR_s.h"

#include "ecom_grt_globals_control_interfaces2.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus

#define ccom_tag_calpolestr_c_elems(_ptr_) (EIF_INTEGER)(ULONG)(((ecom_control_library::tagCALPOLESTR *)_ptr_)->cElems)

#define ccom_tag_calpolestr_set_c_elems(_ptr_, _field_) ((((ecom_control_library::tagCALPOLESTR *)_ptr_)->cElems) = (ULONG)_field_)

#define ccom_tag_calpolestr_p_elems(_ptr_) (EIF_REFERENCE)(grt_ce_control_interfaces2.ccom_ce_pointed_cell_258 (((ecom_control_library::tagCALPOLESTR *)_ptr_)->pElems, NULL))

#define ccom_tag_calpolestr_set_p_elems(_ptr_, _field_) (grt_ce_control_interfaces2.ccom_free_memory_pointed_258(((ecom_control_library::tagCALPOLESTR *)_ptr_)->pElems), (((ecom_control_library::tagCALPOLESTR *)_ptr_)->pElems) = grt_ec_control_interfaces2.ccom_ec_pointed_cell_258 (eif_access (_field_), NULL))

#endif
#ifdef __cplusplus
}
#endif

#endif