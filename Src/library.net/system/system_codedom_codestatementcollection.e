indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeStatementCollection"

external class
	SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_COLLECTIONBASE
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create
	make_codestatementcollection_1,
	make_codestatementcollection_2,
	make_codestatementcollection

feature {NONE} -- Initialization

	frozen make_codestatementcollection_1 (value: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeStatementCollection) use System.CodeDom.CodeStatementCollection"
		end

	frozen make_codestatementcollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement[]) use System.CodeDom.CodeStatementCollection"
		end

	frozen make_codestatementcollection is
		external
			"IL creator use System.CodeDom.CodeStatementCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODESTATEMENT is
		external
			"IL signature (System.Int32): System.CodeDom.CodeStatement use System.CodeDom.CodeStatementCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeStatementCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_code_statement (value: SYSTEM_CODEDOM_CODESTATEMENT): INTEGER is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Int32 use System.CodeDom.CodeStatementCollection"
		alias
			"Add"
		end

	frozen add_range_array_code_statement (value: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL signature (System.CodeDom.CodeStatement[]): System.Void use System.CodeDom.CodeStatementCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeStatementCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeStatement[], System.Int32): System.Void use System.CodeDom.CodeStatementCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODESTATEMENT): INTEGER is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Int32 use System.CodeDom.CodeStatementCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeStatementCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODESTATEMENT): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Boolean use System.CodeDom.CodeStatementCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeStatementCollection): System.Void use System.CodeDom.CodeStatementCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_CODEEXPRESSION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Int32 use System.CodeDom.CodeStatementCollection"
		alias
			"Add"
		end

end -- class SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION
