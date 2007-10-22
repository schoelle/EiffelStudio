#ifndef MK1MF_BUILD
  /* auto-generated by Configure for crypto/cversion.c:
   * for Unix builds, crypto/Makefile.ssl generates functional definitions;
   * Windows builds (and other mk1mf builds) compile cversion.c with
   * -DMK1MF_BUILD and use definitions added to this file by util/mk1mf.pl. */
  #error "Windows builds (PLATFORM=VC-WIN64A) use mk1mf.pl-created Makefiles"
#endif
#ifdef MK1MF_PLATFORM_VC_WIN64A
  /* auto-generated/updated by util/mk1mf.pl for crypto/cversion.c */
  #define CFLAGS "cl  /MD /Ox /W3 /Gs0 /GF /Gy /nologo -DWIN32_LEAN_AND_MEAN -DL_ENDIAN -DDSO_WIN32 -DOPENSSL_SYSNAME_WIN32 -DOPENSSL_SYSNAME_WINNT -DUNICODE -D_UNICODE -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE -DOPENSSL_USE_APPLINK -I. /Fdout32dll -DOPENSSL_NO_CAMELLIA -DOPENSSL_NO_RC5 -DOPENSSL_NO_MDC2 -DOPENSSL_NO_KRB5 -DOPENSSL_NO_DYNAMIC_ENGINE    "
  #define PLATFORM "VC-WIN64A"
  #define DATE "Mon Oct 22 12:13:27 2007"
#endif
