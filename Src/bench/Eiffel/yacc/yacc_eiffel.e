indexing

	description: 
		"Yacc to Eiffel interface for AST structures %
		%specically for bench.";
	date: "$Date$";
	revision: "$Revision $"

class YACC_EIFFEL

inherit

	EIFFEL_YACC_CONST

creation

	init

feature

	init is
			-- Initialization of the Eiffel-Yacc interface
		local
			as1: CLASS_AS_B;
			as2: ID_AS_B;
			as3: EIFFEL_LIST_B[AST_EIFFEL_B];
			as4: STRING_AS_B;
			as5: INTEGER_AS_B;
			as6: INDEX_AS_B;
			as7: EXPORT_ITEM_AS_B;
			as8: ALL_AS_B;
			as10: FEAT_NAME_ID_AS_B;
			as11: INFIX_AS_B;
			as12: PREFIX_AS_B;
			as13: FORMAL_AS_B;
			as14: CHAR_TYPE_AS_B;
			as15: BOOL_TYPE_AS_B;
			as16: INT_TYPE_AS_B;
			as17: REAL_TYPE_AS_B;
			as18: DOUBLE_TYPE_AS_B;
			as19: FORMAL_DEC_AS_B;
			as20: LIKE_CUR_AS_B;
			as21: LIKE_ID_AS_B;
			as22: CLASS_TYPE_AS_B;
			as23: EXP_TYPE_AS_B;
			as24: BITS_AS_B;
			as25: PARENT_AS_B;
			as26: RENAME_AS_B;
			as27: REAL_AS_B;
			as28: BOOL_AS_B;
			as29: VALUE_AS_B;
			as31: ADDRESS_AS_B;
			as32: PARAN_AS_B;
			as33: UN_MINUS_AS_B;
			as34: UN_PLUS_AS_B;
			as35: UN_OLD_AS_B;
			as36: UN_NOT_AS_B;
			as37: BIN_PLUS_AS_B;
			as38: BIN_MINUS_AS_B;
			as39: BIN_MOD_AS_B;
			as40: BIN_POWER_AS_B;
			as41: BIN_AND_AS_B;
			as42: BIN_AND_THEN_AS_B;
			as43: BIN_OR_AS_B;
			as44: BIN_OR_ELSE_AS_B;
			as45: BIN_IMPLIES_AS_B;
			as46: BIN_XOR_AS_B;
			as47: BIN_EQ_AS_B;
			as48: BIN_NE_AS_B;
			as49: BIN_GT_AS_B;
			as50: BIN_GE_AS_B;
			as51: BIN_LT_AS_B;
			as52: BIN_LE_AS_B;
			as53: BIN_SLASH_AS_B;
			as54: BIN_STAR_AS_B;
			as55: BIN_DIV_AS_B;
			as56: CHAR_AS_B;
			as57: RESULT_AS_B;
			as58: CURRENT_AS_B;
			as59: ACCESS_ID_AS_B;
			as61: NESTED_AS_B;
			as62: EXPR_CALL_AS_B;
			as63: CREATE_AS_B;
			as66: INSPECT_AS_B;
			as67: CASE_AS_B;
			as68: INTERVAL_AS_B;
			as69: IF_AS_B;
			as70: ELSIF_AS_B;
			as71: ASSIGN_AS_B;
			as72: REVERSE_AS_B;
			as73: DEBUG_AS_B;
			as74: RETRY_AS_B;
			as75: INSTR_CALL_AS_B;
			as76: TAGGED_AS_B;
			as77: LOOP_AS_B;
			as78: CHECK_AS_B;
			as79: BODY_AS_B;
			as80: TYPE_DEC_AS_B;
			as81: UNIQUE_AS_B;
			as82: ROUTINE_AS_B;
			as83: EXTERNAL_AS_B;
			as85: CONSTANT_AS_B;
			as86: FEATURE_AS_B;
			as87: SUPPLIERS_AS_B;
			as88: INVARIANT_AS_B;
			as89: VARIANT_AS_B;
			as90: FEATURE_LIST_AS_B;
			as91: DEFERRED_AS_B;
			as92: DO_AS_B;
			as93: ONCE_AS_B;
			as94: REQUIRE_AS_B;
			as95: REQUIRE_ELSE_AS_B;
			as96: ENSURE_AS_B;
			as97: ENSURE_THEN_AS_B;
			as98: FEATURE_CLAUSE_AS_B;
			as99: CREATION_AS_B;
			as100: ARRAY_AS_B;
			as101: UN_STRIP_AS_B;
			as102: NONE_TYPE_AS_B;
			as103: CLIENT_AS_B;
			as104: ACCESS_FEAT_AS_B;
			as105: ACCESS_INV_AS_B;
			as106: ACCESS_ASSERT_AS_B;
			as107: BIN_FREE_AS_B;
			as108: UN_FREE_AS_B;
			as109: NESTED_EXPR_AS_B;
			as110: BIT_CONST_AS_B;
			as111: BITS_SYMBOL_AS_B;
			as112: POINTER_TYPE_AS_B;
			as113: ADDRESS_CURRENT_AS_B;
			as114: ADDRESS_RESULT_AS_B;
			as115: EXTERNAL_LANG_AS_B;
		do
			!!as1;
			as1.pass_address(class_as);
			!!as2.make (0);
			as2.pass_address(id_as);
			!!as3.make (0);
			as3.pass_address(construct_list_as);
			!!as4;
			as4.pass_address(string_as);
			!!as5;
			as5.pass_address(integer_as);
			!!as6;
			as6.pass_address(index_as);
			!!as7;
			as7.pass_address(export_item_as);
			!!as8;
			as8.pass_address(all_as);
			!!as10;
			as10.pass_address(feat_name_id_as);
			!!as11;
			as11.pass_address(infix_as);
			!!as12;
			as12.pass_address(prefix_as);
			!!as13;
			as13.pass_address(formal_as);
			!!as14;
			as14.pass_address(char_type_as);
			!!as15;
			as15.pass_address (bool_type_as);
			!!as16;
			as16.pass_address (int_type_as);
			!!as17;
			as17.pass_address (real_type_as);
			!!as18;
			as18.pass_address (double_type_as);
			!!as19;
			as19.pass_address (formal_dec_as);
			!!as20;
			as20.pass_address (like_cur_as);
			!!as21;
			as21.pass_address (like_id_as);
			!!as22;
			as22.pass_address (class_type_as);
			!!as23;
			as23.pass_address (exp_type_as);
			!!as24;
			as24.pass_address (bits_as);
			!!as25;
			as25.pass_address (parent_as);
			!!as26;
			as26.pass_address (rename_as);
			!!as27;
			as27.pass_address (real_as);
			!!as28;
			as28.pass_address (bool_as);
			!!as29;
			as29.pass_address (value_as);
			!!as31;
			as31.pass_address (address_as);
			!!as32;
			as32.pass_address (paran_as);
			!!as33;
			as33.pass_address (un_minus_as);
			!!as34;
			as34.pass_address (un_plus_as);
			!!as35;
			as35.pass_address (un_old_as);
			!!as36;
			as36.pass_address (un_not_as);
			!!as37;
			as37.pass_address (bin_plus_as);
			!!as38;
			as38.pass_address (bin_minus_as);
			!!as39;
			as39.pass_address (bin_mod_as);
			!!as40;
			as40.pass_address (bin_power_as);
			!!as41;
			as41.pass_address (bin_and_as);
			!!as42;
			as42.pass_address (bin_and_then_as);
			!!as43;
			as43.pass_address (bin_or_as);
			!!as44;
			as44.pass_address (bin_or_else_as);
			!!as45;
			as45.pass_address (bin_implies_as);
			!!as46;
			as46.pass_address (bin_xor_as);
			!!as47;
			as47.pass_address (bin_eq_as);
			!!as48;
			as48.pass_address (bin_ne_as);
			!!as49;
			as49.pass_address (bin_gt_as);
			!!as50;
			as50.pass_address (bin_ge_as);
			!!as51;
			as51.pass_address (bin_lt_as);
			!!as52;
			as52.pass_address (bin_le_as);
			!!as53;
			as53.pass_address (bin_slash_as);
			!!as54;
			as54.pass_address (bin_star_as);
			!!as55;
			as55.pass_address (bin_div_as);
			!!as56;
			as56.pass_address (char_as);
			!!as57;
			as57.pass_address (result_as);
			!!as58;
			as58.pass_address (current_as);
			!!as59;
			as59.pass_address (access_id_as);
			!!as61;
			as61.pass_address (nested_as);
			!!as62;
			as62.pass_address (expr_call_as);
			!!as63;
			as63.pass_address (create_as);
			!!as66;
			as66.pass_address (inspect_as);
			!!as67;
			as67.pass_address (case_as);
			!!as68;
			as68.pass_address (interval_as);
			!!as69;
			as69.pass_address (if_as);
			!!as70;
			as70.pass_address (elsif_as);
			!!as71;
			as71.pass_address (assign_as);
			!!as72;
			as72.pass_address (reverse_as);
			!!as73;
			as73.pass_address (debug_as);
			!!as74;
			as74.pass_address (retry_as);
			!!as75;
			as75.pass_address (instr_call_as);
			!!as76;
			as76.pass_address (tagged_as);
			!!as77;
			as77.pass_address (loop_as);
			!!as78;
			as78.pass_address (check_as);
			!!as79;
			as79.pass_address (body_as);
			!!as80;
			as80.pass_address (type_dec_as);
			!!as81;
			as81.pass_address (unique_as);
			!!as82;
			as82.pass_address (routine_as);
			!!as83;
			as83.pass_address (external_as);
			!!as85;
			as85.pass_address (constant_as);
			!!as86;
			as86.pass_address (feature_as);
			!!as87.make;
			as87.pass_address (suppliers_as);
			!!as88;
			as88.pass_address (invariant_as);
			!!as89;
			as89.pass_address (variant_as);
			!!as90;
			as90.pass_address (feature_list_as);
			!!as91;
			as91.pass_address (deferred_as);
			!!as92;
			as92.pass_address (do_as);
			!!as93;
			as93.pass_address (once_as);
			!!as94;
			as94.pass_address (require_as);
			!!as95;
			as95.pass_address (require_else_as);
			!!as96;
			as96.pass_address (ensure_as);
			!!as97;
			as97.pass_address (ensure_then_as);
			!!as98;
			as98.pass_address (feature_clause_as);
			!!as99;
			as99.pass_address (creation_as);
			!!as100;
			as100.pass_address (array_as);
			!!as101;
			as101.pass_address (un_strip_as);
			!!as102;
			as102.pass_address (none_type_as);
			!!as103;
			as103.pass_address (client_as);
			!!as104;
			as104.pass_address (access_feat_as);
			!!as105;
			as105.pass_address (access_inv_as);
			!!as106;
			as106.pass_address (access_assert_as);
			!!as107;
			as107.pass_address (bin_free_as);
			!!as108;
			as108.pass_address (un_free_as);
			!!as109;
			as109.pass_address (nested_expr_as);
			!!as110;
			as110.pass_address (bit_const_as);
			!!as111;
			as111.pass_address (bits_symbol_as);
			!!as112;
			as112.pass_address (pointer_type_as);
			!!as113;
			as113.pass_address (address_current_as);
			!!as114;
			as114.pass_address (address_result_as);
			!!as115;
			as115.pass_address (external_lang_as);
		end;

end
