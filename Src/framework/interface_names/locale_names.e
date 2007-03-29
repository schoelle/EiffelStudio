indexing
	description: "Mapping between locale ids and names"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALE_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	languages: HASH_TABLE [STRING_GENERAL, STRING] is
		once
			create Result.make (130)
			Result.force (locale.translate ("Afrikaans"), "af")
			Result.force (locale.translate ("Amharic"), "am")
			Result.force (locale.translate ("Arabic"), "ar")
			Result.force (locale.translate ("Mapudungun"), "arn")
			Result.force (locale.translate ("Assamese"), "as")
			Result.force (locale.translate ("Azeri"), "az")
			Result.force (locale.translate ("Bashkir"), "ba")
			Result.force (locale.translate ("Belarusian"), "be")
			Result.force (locale.translate ("Bulgarian"), "bg")
			Result.force (locale.translate ("Bengali"), "bn")
			Result.force (locale.translate ("Tibetan"), "bo")
			Result.force (locale.translate ("Breton"), "br")
			Result.force (locale.translate ("Bosnian"), "bs")
			Result.force (locale.translate ("Catalan"), "ca")
			Result.force (locale.translate ("Corsican"), "co")
			Result.force (locale.translate ("Czech"), "cs")
			Result.force (locale.translate ("Welsh"), "cy")
			Result.force (locale.translate ("Danish"), "da")
			Result.force (locale.translate ("German"), "de")
			Result.force (locale.translate ("Lower Sorbian"), "dsb")
			Result.force (locale.translate ("Divehi"), "dv")
			Result.force (locale.translate ("Greek"), "el")
			Result.force (locale.translate ("English"), "en")
			Result.force (locale.translate ("Spanish"), "es")
			Result.force (locale.translate ("Estonian"), "et")
			Result.force (locale.translate ("Basque"), "eu")
			Result.force (locale.translate ("Persian"), "fa")
			Result.force (locale.translate ("Finnish"), "fi")
			Result.force (locale.translate ("Filipino"), "fil")
			Result.force (locale.translate ("Faroese"), "fo-FO")
			Result.force (locale.translate ("French"), "fr")
			Result.force (locale.translate ("Frisian"), "fy")
			Result.force (locale.translate ("Irish"), "ga")
			Result.force (locale.translate ("Dari"), "gbz")
			Result.force (locale.translate ("Galician"), "gl")
			Result.force (locale.translate ("Alsatian"), "gsw")
			Result.force (locale.translate ("Gujarati"), "gu")
			Result.force (locale.translate ("Hausa"), "ha")
			Result.force (locale.translate ("Hebrew"), "he")
			Result.force (locale.translate ("Hindi"), "hi")
			Result.force (locale.translate ("Croatian"), "hr")
			Result.force (locale.translate ("Hungarian"), "hu")
			Result.force (locale.translate ("Armenian"), "hy")
			Result.force (locale.translate ("Indonesian"), "id")
			Result.force (locale.translate ("Igbo"), "ig")
			Result.force (locale.translate ("Yi"), "ii")
			Result.force (locale.translate ("Icelandic"), "is")
			Result.force (locale.translate ("Italian"), "it")
			Result.force (locale.translate ("Inuktitut"), "iu")
			Result.force (locale.translate ("Japanese"), "ja")
			Result.force (locale.translate ("Georgian"), "ka")
			Result.force (locale.translate ("Khmer"), "kh")
			Result.force (locale.translate ("Kazakh"), "kk")
			Result.force (locale.translate ("Greenlandic"), "kl")
			Result.force (locale.translate ("Kannada"), "kn")
			Result.force (locale.translate ("Korean"), "ko")
			Result.force (locale.translate ("Konkani"), "kok")
			Result.force (locale.translate ("Kyrgyz"), "ky")
			Result.force (locale.translate ("Luxembourgish"), "lb")
			Result.force (locale.translate ("Lao"), "lo")
			Result.force (locale.translate ("Lithuanian"), "lt")
			Result.force (locale.translate ("Latvian"), "lv")
			Result.force (locale.translate ("Maori"), "mi")
			Result.force (locale.translate ("Macedonian"), "mk")
			Result.force (locale.translate ("Malayalam"), "ml")
			Result.force (locale.translate ("Mongolian"), "mn")
			Result.force (locale.translate ("Mohawk"), "moh")
			Result.force (locale.translate ("Marathi"), "mr")
			Result.force (locale.translate ("Malay"), "ms")
			Result.force (locale.translate ("Maltese"), "mt")
			Result.force (locale.translate ("Norwegian"), "nb")
			Result.force (locale.translate ("Nepali"), "ne")
			Result.force (locale.translate ("Dutch"), "nl")
			Result.force (locale.translate ("Norwegian"), "nn")
			Result.force (locale.translate ("Sesotho sa Leboa/Northern Sotho"), "ns")
			Result.force (locale.translate ("Occitan"), "oc")
			Result.force (locale.translate ("Oriya"), "or")
			Result.force (locale.translate ("Punjabi"), "pa")
			Result.force (locale.translate ("Polish"), "pl")
			Result.force (locale.translate ("Pashto"), "ps")
			Result.force (locale.translate ("Portuguese"), "pt")
			Result.force (locale.translate ("K'iche"), "qut")
			Result.force (locale.translate ("Quechua"), "quz")
			Result.force (locale.translate ("Romansh"), "rm")
			Result.force (locale.translate ("Romanian"), "ro")
			Result.force (locale.translate ("Russian"), "ru")
			Result.force (locale.translate ("Kinyarwanda"), "rw")
			Result.force (locale.translate ("Sanskrit"), "sa")
			Result.force (locale.translate ("Yakut"), "sah")
			Result.force (locale.translate ("Sami"), "se")
			Result.force (locale.translate ("Sinhala"), "si")
			Result.force (locale.translate ("Slovak"), "sk")
			Result.force (locale.translate ("Slovenian"), "sl")
			Result.force (locale.translate ("Sami"), "sma")
			Result.force (locale.translate ("Albanian"), "sq")
			Result.force (locale.translate ("Serbian"), "sr")
			Result.force (locale.translate ("Swedish"), "sv")
			Result.force (locale.translate ("Swahili"), "sw")
			Result.force (locale.translate ("Syriac"), "syr")
			Result.force (locale.translate ("Tamil"), "ta")
			Result.force (locale.translate ("Telugu"), "te")
			Result.force (locale.translate ("Tajik"), "tg")
			Result.force (locale.translate ("Thai"), "th")
			Result.force (locale.translate ("Turkmen"), "tk")
			Result.force (locale.translate ("Tamazight"), "tmz")
			Result.force (locale.translate ("Setswana/Tswana"), "tn")
			Result.force (locale.translate ("Urdu"), "tr")
			Result.force (locale.translate ("Turkish"), "tr")
			Result.force (locale.translate ("Tatar"), "tt")
			Result.force (locale.translate ("Uighur"), "ug")
			Result.force (locale.translate ("Ukrainian"), "uk")
			Result.force (locale.translate ("Urdu"), "ur")
			Result.force (locale.translate ("Uzbek"), "uz")
			Result.force (locale.translate ("Vietnamese"), "vi")
			Result.force (locale.translate ("Upper Sorbian"), "wen")
			Result.force (locale.translate ("Wolof"), "wo")
			Result.force (locale.translate ("Xhosa/isiXhosa"), "xh")
			Result.force (locale.translate ("Yoruba"), "yo")
			Result.force (locale.translate ("Chinese"), "zh")
			Result.force (locale.translate ("Zulu/isiZulu"), "zu")
		end

	locales: HASH_TABLE [STRING_GENERAL, STRING] is
		once
			create Result.make (300)
			Result.force (locale.translate ("Afrikaans (South Africa)"), "af_za")
			Result.force (locale.translate ("Amharic (Ethiopia)"), "am_et")
			Result.force (locale.translate ("Arabic (U.A.E.)"), "ar_ae")
			Result.force (locale.translate ("Arabic (Bahrain)"), "ar_bh")
			Result.force (locale.translate ("Arabic (Algeria)"), "ar_dz")
			Result.force (locale.translate ("Arabic (Egypt)"), "ar_eg")
			Result.force (locale.translate ("Arabic (Iraq)"), "ar_iq")
			Result.force (locale.translate ("Arabic (Jordan)"), "ar_jo")
			Result.force (locale.translate ("Arabic (Kuwait)"), "ar_kw")
			Result.force (locale.translate ("Arabic (Lebanon)"), "ar_lb")
			Result.force (locale.translate ("Arabic (Libya)"), "ar_ly")
			Result.force (locale.translate ("Arabic (Morocco)"), "ar_ma")
			Result.force (locale.translate ("Arabic (Oman)"), "ar_om")
			Result.force (locale.translate ("Arabic (Qatar)"), "ar_qa")
			Result.force (locale.translate ("Arabic (Saudi Arabia)"), "ar_sa")
			Result.force (locale.translate ("Arabic (Syria)"), "ar_sy")
			Result.force (locale.translate ("Arabic (Tunisia)"), "ar_tn")
			Result.force (locale.translate ("Arabic (Yemen)"), "ar_ye")
			Result.force (locale.translate ("Mapudungun (Chile)"), "arn_cl")
			Result.force (locale.translate ("Assamese (India)"), "as_in")
			Result.force (locale.translate ("Azeri (Azerbaijan, Cyrillic)"), "az_cyrl_az")
			Result.force (locale.translate ("Azeri (Azerbaijan, Latin)"), "az_latn_az")
			Result.force (locale.translate ("Bashkir (Russia)"), "ba_ru")
			Result.force (locale.translate ("Belarusian (Belarus)"), "be_by")
			Result.force (locale.translate ("Bulgarian (Bulgaria)"), "bg_bg")
			Result.force (locale.translate ("Bengali (India)"), "bn_in")
			Result.force (locale.translate ("Tibetan (Bhutan)"), "bo_bt")
			Result.force (locale.translate ("Tibetan (PRC)"), "bo_cn")
			Result.force (locale.translate ("Breton (France)"), "br_fr")
			Result.force (locale.translate ("Bosnian (Bosnia and Herzegovina, Cyrillic)"), "bs_cyrl_ba")
			Result.force (locale.translate ("Bosnian (Bosnia and Herzegovina, Latin)"), "bs_latn_ba")
			Result.force (locale.translate ("Catalan (Catalan)"), "ca_es")
			Result.force (locale.translate ("Corsican (France)"), "co_fr")
			Result.force (locale.translate ("Czech (Czech Republic)"), "cs_cz")
			Result.force (locale.translate ("Welsh (United Kingdom)"), "cy_gb")
			Result.force (locale.translate ("Danish (Denmark)"), "da_dk")
			Result.force (locale.translate ("German (Austria)"), "de_at")
			Result.force (locale.translate ("German (Switzerland)"), "de_ch")
			Result.force (locale.translate ("German (Germany)"), "de_de")
			Result.force (locale.translate ("German (Liechtenstein)"), "de_li")
			Result.force (locale.translate ("German (Luxembourg)"), "de_lu")
			Result.force (locale.translate ("Lower Sorbian (Germany)"), "dsb_de")
			Result.force (locale.translate ("Divehi (Maldives)"), "dv_mv")
			Result.force (locale.translate ("Greek (Greece)"), "el_gr")
			Result.force (locale.translate ("English (Caribbean)"), "en_029")
			Result.force (locale.translate ("English (Australia)"), "en_au")
			Result.force (locale.translate ("English (Belize)"), "en_bz")
			Result.force (locale.translate ("English (Canada)"), "en_ca")
			Result.force (locale.translate ("English (Caribbean)"), "en_cb")
			Result.force (locale.translate ("English (United Kingdom)"), "en_gb")
			Result.force (locale.translate ("English (Ireland)"), "en_ie")
			Result.force (locale.translate ("English (India)"), "en_in")
			Result.force (locale.translate ("English (Jamaica)"), "en_jm")
			Result.force (locale.translate ("English (Malaysia)"), "en_my")
			Result.force (locale.translate ("English (New Zealand)"), "en_nz")
			Result.force (locale.translate ("English (Philippines)"), "en_ph")
			Result.force (locale.translate ("English (Singapore)"), "en_sg")
			Result.force (locale.translate ("English (Trinidad and Tobago)"), "en_tt")
			Result.force (locale.translate ("English (United States)"), "en_us")
			Result.force (locale.translate ("English (South Africa)"), "en_za")
			Result.force (locale.translate ("English (Zimbabwe)"), "en_zw")
			Result.force (locale.translate ("Spanish (Argentina)"), "es_ar")
			Result.force (locale.translate ("Spanish (Bolivia)"), "es_bo")
			Result.force (locale.translate ("Spanish (Chile)"), "es_cl")
			Result.force (locale.translate ("Spanish (Colombia)"), "es_co")
			Result.force (locale.translate ("Spanish (Costa Rica)"), "es_cr")
			Result.force (locale.translate ("Spanish (Dominican Republic)"), "es_do")
			Result.force (locale.translate ("Spanish (Ecuador)"), "es_ec")
			Result.force (locale.translate ("Spanish (Spain)"), "es_es")
			Result.force (locale.translate ("Spanish (Guatemala)"), "es_gt")
			Result.force (locale.translate ("Spanish (Honduras)"), "es_hn")
			Result.force (locale.translate ("Spanish (Mexico)"), "es_mx")
			Result.force (locale.translate ("Spanish (Nicaragua)"), "es_ni")
			Result.force (locale.translate ("Spanish (Panama)"), "es_pa")
			Result.force (locale.translate ("Spanish (Peru)"), "es_pe")
			Result.force (locale.translate ("Spanish (Puerto Rico)"), "es_pr")
			Result.force (locale.translate ("Spanish (Paraguay)"), "es_py")
			Result.force (locale.translate ("Spanish (El Salvador)"), "es_sv")
			Result.force (locale.translate ("Spanish (United States)"), "es_us")
			Result.force (locale.translate ("Spanish (Uruguay)"), "es_uy")
			Result.force (locale.translate ("Spanish (Venezuela)"), "es_ve")
			Result.force (locale.translate ("Estonian (Estonia)"), "et_ee")
			Result.force (locale.translate ("Basque (Basque)"), "eu_es")
			Result.force (locale.translate ("Persian (Iran)"), "fa_ir")
			Result.force (locale.translate ("Finnish (Finland)"), "fi_fi")
			Result.force (locale.translate ("Filipino (Philippines)"), "fil_ph")
			Result.force (locale.translate ("Faroese (Faroe Islands)"), "fo_fo")
			Result.force (locale.translate ("French (Belgium)"), "fr_be")
			Result.force (locale.translate ("French (Canada)"), "fr_ca")
			Result.force (locale.translate ("French (Switzerland)"), "fr_ch")
			Result.force (locale.translate ("French (France)"), "fr_fr")
			Result.force (locale.translate ("French (Luxembourg)"), "fr_lu")
			Result.force (locale.translate ("French (Monaco)"), "fr_mc")
			Result.force (locale.translate ("Frisian (Netherlands)"), "fy_nl")
			Result.force (locale.translate ("Irish (Ireland)"), "ga_ie")
			Result.force (locale.translate ("Dari (Afghanistan)"), "gbz_af")
			Result.force (locale.translate ("Galician (Spain)"), "gl_es")
			Result.force (locale.translate ("Alsatian (France)"), "gsw_fr")
			Result.force (locale.translate ("Gujarati (India)"), "gu_in")
			Result.force (locale.translate ("Hausa (Nigeria, Latin)"), "ha_latn_ng")
			Result.force (locale.translate ("Hebrew (Israel)"), "he_il")
			Result.force (locale.translate ("Hindi (India)"), "hi_in")
			Result.force (locale.translate ("Croatian (Bosnia and Herzegovina, Latin)"), "hr_ba")
			Result.force (locale.translate ("Croatian (Croatia)"), "hr_hr")
			Result.force (locale.translate ("Hungarian (Hungary)"), "hu_hu")
			Result.force (locale.translate ("Armenian (Armenia)"), "hy_am")
			Result.force (locale.translate ("Indonesian (Indonesia)"), "id_id")
			Result.force (locale.translate ("Igbo (Nigeria)"), "ig_ng")
			Result.force (locale.translate ("Yi (PRC)"), "ii_cn")
			Result.force (locale.translate ("Icelandic (Iceland)"), "is_is")
			Result.force (locale.translate ("Italian (Switzerland)"), "it_ch")
			Result.force (locale.translate ("Italian (Italy)"), "it_it")
			Result.force (locale.translate ("Inuktitut (Canada, Syllabics)"), "iu_cans_ca")
			Result.force (locale.translate ("Inuktitut (Canada, Latin)"), "iu_latn_ca")
			Result.force (locale.translate ("Japanese (Japan)"), "ja_jp")
			Result.force (locale.translate ("Georgian (Georgia)"), "ka_ge")
			Result.force (locale.translate ("Khmer (Cambodia)"), "kh_kh")
			Result.force (locale.translate ("Kazakh (Kazakhstan)"), "kk_kz")
			Result.force (locale.translate ("Greenlandic (Greenland)"), "kl_gl")
			Result.force (locale.translate ("Kannada (India)"), "kn_in")
			Result.force (locale.translate ("Korean (Korea)"), "ko_kr")
			Result.force (locale.translate ("Konkani (India)"), "kok_in")
			Result.force (locale.translate ("Kyrgyz (Kyrgyzstan)"), "ky_kg")
			Result.force (locale.translate ("Luxembourgish (Luxembourg)"), "lb_lu")
			Result.force (locale.translate ("Lao (Lao PDR)"), "lo_la")
			Result.force (locale.translate ("Lithuanian (Lithuania)"), "lt_lt")
			Result.force (locale.translate ("Latvian (Latvia)"), "lv_lv")
			Result.force (locale.translate ("Maori (New Zealand)"), "mi_nz")
			Result.force (locale.translate ("Macedonian (Macedonia, FYROM)"), "mk_mk")
			Result.force (locale.translate ("Malayalam (India)"), "ml_in")
			Result.force (locale.translate ("Mongolian (Mongolia)"), "mn_cyrl_mn")
			Result.force (locale.translate ("Mongolian (PRC)"), "mn_mong_cn")
			Result.force (locale.translate ("Mohawk (Canada)"), "moh_ca")
			Result.force (locale.translate ("Marathi (India)"), "mr_in")
			Result.force (locale.translate ("Malay (Brunei Darussalam)"), "ms_bn")
			Result.force (locale.translate ("Malay (Malaysia)"), "ms_my")
			Result.force (locale.translate ("Maltese (Malta)"), "mt_mt")
			Result.force (locale.translate ("Norwegian (Bokm�l, Norway)"), "nb_no")
			Result.force (locale.translate ("Nepali (India)"), "ne_in")
			Result.force (locale.translate ("Nepali (Nepal)"), "ne_np")
			Result.force (locale.translate ("Dutch (Belgium)"), "nl_be")
			Result.force (locale.translate ("Dutch (Netherlands)"), "nl_nl")
			Result.force (locale.translate ("Norwegian (Nynorsk, Norway)"), "nn_no")
			Result.force (locale.translate ("Sesotho sa Leboa/Northern Sotho (South Africa)"), "ns_za")
			Result.force (locale.translate ("Occitan (France)"), "oc_fr")
			Result.force (locale.translate ("Oriya (India)"), "or_in")
			Result.force (locale.translate ("Punjabi (India)"), "pa_in")
			Result.force (locale.translate ("Polish (Poland)"), "pl_pl")
			Result.force (locale.translate ("Pashto (Afghanistan)"), "ps_af")
			Result.force (locale.translate ("Portuguese (Brazil)"), "pt_br")
			Result.force (locale.translate ("Portuguese (Portugal)"), "pt_pt")
			Result.force (locale.translate ("K'iche (Guatemala)"), "qut_gt")
			Result.force (locale.translate ("Quechua (Bolivia)"), "quz_bo")
			Result.force (locale.translate ("Quechua (Ecuador)"), "quz_ec")
			Result.force (locale.translate ("Quechua (Peru)"), "quz_pe")
			Result.force (locale.translate ("Romansh (Switzerland)"), "rm_ch")
			Result.force (locale.translate ("Romanian (Romania)"), "ro_ro")
			Result.force (locale.translate ("Russian (Russia)"), "ru_ru")
			Result.force (locale.translate ("Kinyarwanda (Rwanda)"), "rw_rw")
			Result.force (locale.translate ("Sanskrit (India)"), "sa_in")
			Result.force (locale.translate ("Yakut (Russia)"), "sah_ru")
			Result.force (locale.translate ("Sami (Northern, Finland)"), "se_fi")
			Result.force (locale.translate ("Sami (Northern, Norway)"), "se_no")
			Result.force (locale.translate ("Sami (Northern, Sweden)"), "se_se")
			Result.force (locale.translate ("Sinhala (Sri Lanka)"), "si_lk")
			Result.force (locale.translate ("Slovak (Slovakia)"), "sk_sk")
			Result.force (locale.translate ("Slovenian (Slovenia)"), "sl_si")
			Result.force (locale.translate ("Sami (Southern, Norway)"), "sma_no")
			Result.force (locale.translate ("Sami (Southern, Sweden)"), "sma_se")
			Result.force (locale.translate ("Sami (Lule, Norway)"), "smj_no")
			Result.force (locale.translate ("Sami (Lule, Sweden)"), "smj_se")
			Result.force (locale.translate ("Sami (Inari, Finland)"), "smn_fi")
			Result.force (locale.translate ("Sami (Skolt, Finland)"), "sms_fi")
			Result.force (locale.translate ("Albanian (Albania)"), "sq_AL")
			Result.force (locale.translate ("Serbian (Bosnia and Herzegovina, Cyrillic)"), "sr_cyrl_ba")
			Result.force (locale.translate ("Serbian (Serbia and Montenegro, Cyrillic)"), "sr_cyrl_cs")
			Result.force (locale.translate ("Serbian (Bosnia and Herzegovina, Latin)"), "sr_latn_ba")
			Result.force (locale.translate ("Serbian (Serbia and Montenegro, Latin)"), "sr_latn_cs")
			Result.force (locale.translate ("Swedish (Finland)"), "sv_fi")
			Result.force (locale.translate ("Swedish (Sweden)"), "sv_se")
			Result.force (locale.translate ("Swahili (Kenya)"), "sw_ke")
			Result.force (locale.translate ("Syriac (Syria)"), "syr_sy")
			Result.force (locale.translate ("Tamil (India)"), "ta_in")
			Result.force (locale.translate ("Telugu (India)"), "te_in")
			Result.force (locale.translate ("Tajik (Tajikistan)"), "tg_cyrl_tj")
			Result.force (locale.translate ("Thai (Thailand)"), "th_th")
			Result.force (locale.translate ("Turkmen (Turkmenistan)"), "tk_tm")
			Result.force (locale.translate ("Tamazight (Algeria, Latin)"), "tmz_latn_dz")
			Result.force (locale.translate ("Setswana/Tswana (South Africa)"), "tn_za")
			Result.force (locale.translate ("Urdu (India)"), "tr_in")
			Result.force (locale.translate ("Turkish (Turkey)"), "tr_tr")
			Result.force (locale.translate ("Tatar (Russia)"), "tt_ru")
			Result.force (locale.translate ("Uighur (PRC)"), "ug_cn")
			Result.force (locale.translate ("Ukrainian (Ukraine)"), "uk_ua")
			Result.force (locale.translate ("Urdu (Pakistan)"), "ur_pk")
			Result.force (locale.translate ("Uzbek (Uzbekistan, Cyrillic)"), "uz_cyrl_uz")
			Result.force (locale.translate ("Uzbek (Uzbekistan, Latin)"), "uz_latn_uz")
			Result.force (locale.translate ("Vietnamese (Vietnam)"), "vi_vn")
			Result.force (locale.translate ("Upper Sorbian (Germany)"), "wen_de")
			Result.force (locale.translate ("Wolof (Senegal)"), "wo_sn")
			Result.force (locale.translate ("Xhosa/isiXhosa (South Africa)"), "xh_za")
			Result.force (locale.translate ("Yoruba (Nigeria)"), "yo_ng")
			Result.force (locale.translate ("Chinese (PRC)"), "zh_cn")
			Result.force (locale.translate ("Chinese (Hong Kong SAR, PRC)"), "zh_hk")
			Result.force (locale.translate ("Chinese (Macao SAR)"), "zh_mo")
			Result.force (locale.translate ("Chinese (Singapore)"), "zh_sg")
			Result.force (locale.translate ("Chinese (Taiwan)"), "zh_tw")
			Result.force (locale.translate ("Zulu/isiZulu (South Africa)"), "zu_za")
		end

	locales_from_array (a_array_of_id: ARRAY [STRING]): like locales is
			-- Locale pairs of names and locale ids.
			-- Names have been translated according to current selected locale.
		require
			a_array_of_id_not_void: a_array_of_id /= Void
		local
			l_array: like a_array_of_id
			i: INTEGER
			l_displayed_name: STRING_GENERAL
			l_langs, l_locales: HASH_TABLE [STRING_GENERAL, STRING]
			l_value: STRING
		do
			create Result.make (a_array_of_id.count)
			l_langs := languages
			l_locales := locales
			l_array := a_array_of_id
			from
				i := l_array.lower
			until
				i > l_array.upper
			loop
				l_value := l_array.item (i).as_lower
				if l_locales.has_key (l_value) then
					l_displayed_name := l_locales.found_item
				elseif l_langs.has_key (l_value) then
					l_displayed_name := l_langs.found_item
				else
					l_displayed_name := l_array.item (i)
				end
				Result.force (l_displayed_name, l_array.item (i))
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
