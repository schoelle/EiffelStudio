indexing
	description: "Language Identifiers"
	author: "Neil Collier"
	date: "2002/04/08 5:43:43"
	revision: "1.0$"

class
	WEL_LANGUAGE_IDENTIFIERS
	
feature {NONE} -- Language Identifiers 

	identifiers: HASH_TABLE [STRING, INTEGER] is
			-- Language identifiers.
			-- The numeric constants are taken from Microsoft documentation at:
			-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/intl/nls_238z.asp
		once
			create Result.make(0)
			Result.extend ("Language Neutral", 0x0)
			Result.extend ("The language for the invariant locale.", 0x007f)
			Result.extend ("Process or User Default Language", 0x0400)
			Result.extend ("System Default Language", 0x0800)
			Result.extend ("Afrikaans ", 0x0436)
			Result.extend ("Albanian", 0x041c)
			Result.extend ("Arabic (Saudi Arabia)", 0x0401)
			Result.extend ("Arabic (Iraq) ", 0x0801)
			Result.extend ("Arabic (Egypt)", 0x0c01)
			Result.extend ("Arabic (Libya)", 0x1001)
			Result.extend ("Arabic (Algeria)", 0x1401)
			Result.extend ("Arabic (Morocco)", 0x1801)
			Result.extend ("Arabic (Tunisia)", 0x1c01)
			Result.extend ("Arabic (Oman)", 0x2001)
			Result.extend ("Arabic (Yemen)", 0x2401)
			Result.extend ("Arabic (Syria)", 0x2801)
			Result.extend ("Arabic (Jordan)", 0x2c01)
			Result.extend ("Arabic (Lebanon)", 0x3001)
			Result.extend ("Arabic (Kuwait)", 0x3401)
			Result.extend ("Arabic (U.A.E.)", 0x3801)
			Result.extend ("Arabic (Bahrain)", 0x3c01)
			Result.extend ("Arabic (Qatar)", 0x4001)
			Result.extend ("Armenian", 0x042b)
			Result.extend ("Azeri (Latin)", 0x042c)
			Result.extend ("Azeri (Cyrillic)", 0x082c)
			Result.extend ("Basque", 0x042d)
			Result.extend ("Belarussian", 0x0423)
			Result.extend ("Bulgarian", 0x0402)
			Result.extend ("Burmese", 0x0455)
			Result.extend ("Catalan", 0x0403)
			Result.extend ("Chinese (Taiwan)", 0x0404)
			Result.extend ("Chinese (PRC)", 0x0804)
			Result.extend ("Chinese (Hong Kong SAR, PRC)", 0x0c04)
			Result.extend ("Chinese (Singapore) ", 0x1004)
			Result.extend ("Chinese (Macau SAR)", 0x1404)
			Result.extend ("Croatian", 0x041a)
			Result.extend ("Czech", 0x0405)
			Result.extend ("Danish", 0x0406)
			Result.extend ("Divehi", 0x0465)
			Result.extend ("Dutch (Netherlands) ", 0x0413)
			Result.extend ("Dutch (Belgium)", 0x0813)
			Result.extend ("English (United States)", 0x0409)
			Result.extend ("English (United Kingdom)", 0x0809)
			Result.extend ("English (Australian)", 0x0c09)
			Result.extend ("English (Canadian)", 0x1009)
			Result.extend ("English (New Zealand)", 0x1409)
			Result.extend ("English (Ireland)", 0x1809)
			Result.extend ("English (South Africa)", 0x1c09)
			Result.extend ("English (Jamaica)", 0x2009)
			Result.extend ("English (Caribbean)", 0x2409)
			Result.extend ("English (Belize)", 0x2809)
			Result.extend ("English (Trinidad)", 0x2c09)
			Result.extend ("English (Zimbabwe)", 0x3009)
			Result.extend ("English (Philippines)", 0x3409)
			Result.extend ("Estonian", 0x0425)
			Result.extend ("Faeroese", 0x0438)
			Result.extend ("Farsi", 0x0429)
			Result.extend ("Finnish", 0x040b)
 			Result.extend ("French (Standard)", 0x040c)
			Result.extend ("French (Belgian)", 0x080c)
			Result.extend ("French (Canadian)", 0x0c0c)
			Result.extend ("French (Switzerland)", 0x100c)
			Result.extend ("French (Luxembourg)", 0x140c)
			Result.extend ("French (Monaco)", 0x180c)
			Result.extend ("Galician", 0x0456)
			Result.extend ("Georgian", 0x0437)
			Result.extend ("German (Standard)", 0x0407)
			Result.extend ("German (Switzerland)", 0x0807)
			Result.extend ("German (Austria)", 0x0c07)
			Result.extend ("German (Luxembourg)", 0x1007)
			Result.extend ("German (Liechtenstein)", 0x1407) 
			Result.extend ("Greek", 0x0408)
			Result.extend ("Gujarati", 0x0447)
			Result.extend ("Hebrew", 0x040d)
			Result.extend ("Hindi", 0x0439)
			Result.extend ("Hungarian", 0x040e)
			Result.extend ("Icelandic", 0x040f)
			Result.extend ("Indonesian", 0x0421)
			Result.extend ("Italian (Standard)", 0x0410)
			Result.extend ("Italian (Switzerland)", 0x0810)
			Result.extend ("Japanese", 0x0411)
			Result.extend ("Kannada", 0x044b)
			Result.extend ("Kashmiri", 0x0860)
			Result.extend ("Kazakh", 0x043f)
			Result.extend ("Konkani", 0x0457)
			Result.extend ("Korean",  0x0412)
			Result.extend ("Korean (Johab)", 0x0812)
			Result.extend ("Kyrgyz", 0x0440)
			Result.extend ("Latvian", 0x0426)
			Result.extend ("Lithuanian", 0x0427)
			Result.extend ("Lithuanian (Classic)", 0x0827)
			Result.extend ("FYRO Macedonian", 0x042f)
			Result.extend ("Malay (Malaysian) ", 0x043e)
			Result.extend ("Malay (Brunei Darussalam)", 0x083e)
			Result.extend ("Manipuri", 0x0458)
			Result.extend ("Marathi", 0x044e)
			Result.extend ("Mongolian", 0x0450)
			Result.extend ("Norwegian (Bokmal)", 0x0414)
			Result.extend ("Norwegian (Nynorsk)", 0x0814)
			Result.extend ("Polish", 0x0415)
			Result.extend ("Portuguese (Brazil)", 0x0416)
			Result.extend ("Portuguese (Portugal)", 0x0816)
			Result.extend ("Punjabi", 0x0446)
			Result.extend ("Romanian", 0x0418)
			Result.extend ("Russian", 0x0419)
			Result.extend ("Sanskrit", 0x044f)
			Result.extend ("Serbian (Cyrillic)", 0x0c1a)
			Result.extend ("Serbian (Latin)", 0x081a)
			Result.extend ("Sindhi", 0x0459)
			Result.extend ("Slovak", 0x041b)
			Result.extend ("Slovenian", 0x0424)
			Result.extend ("Spanish (Traditional Sort)", 0x040a)
			Result.extend ("Spanish (Mexican)", 0x080a)
			Result.extend ("Spanish (Modern Sort)", 0x0c0a)
			Result.extend ("Spanish (Guatemala)", 0x100a)
			Result.extend ("Spanish (Costa Rica)", 0x140a)
			Result.extend ("Spanish (Panama)", 0x180a)
			Result.extend ("Spanish (Dominican Republic) ", 0x1c0a)
			Result.extend ("Spanish (Venezuela)", 0x200a)
			Result.extend ("Spanish (Colombia)", 0x240a)
			Result.extend ("Spanish (Peru)", 0x280a)
			Result.extend ("Spanish (Argentina)", 0x2c0a)
			Result.extend ("Spanish (Ecuador)", 0x300a)
			Result.extend ("Spanish (Chile)", 0x340a)
			Result.extend ("Spanish (Uruguay)", 0x380a)
			Result.extend ("Spanish (Paraguay)", 0x3c0a)
			Result.extend ("Spanish (Bolivia)", 0x400a)
			Result.extend ("Spanish (El Salvador) ", 0x440a)
			Result.extend ("Spanish (Honduras)", 0x480a)
			Result.extend ("Spanish (Nicaragua) ", 0x4c0a)
			Result.extend ("Spanish (Puerto Rico)", 0x500a)
			Result.extend ("Sutu", 0x0430)
			Result.extend ("Swahili (Kenya)", 0x0441)  
			Result.extend ("Swedish", 0x041d)  
			Result.extend ("Swedish (Finland)", 0x081d)  
			Result.extend ("Syriac", 0x045a)  
			Result.extend ("Tamil", 0x0449) 
			Result.extend ("Tatar (Tatarstan)", 0x0444)  
			Result.extend ("Telugu", 0x044a)  
			Result.extend ("Thai", 0x041e)  
			Result.extend ("Turkish", 0x041f)  
			Result.extend ("Ukrainian", 0x0422) 
			Result.extend ("Urdu (Pakistan)", 0x0420)  
			Result.extend ("Urdu (India)", 0x0820)  
			Result.extend ("Uzbek (Latin)", 0x0443)  
			Result.extend ("Uzbek (Cyrillic)", 0x0843)  
			Result.extend ("Vietnamese", 0x042a) 

		end
		
end -- class WEL_LANGUAGE_IDENTIFIERS

