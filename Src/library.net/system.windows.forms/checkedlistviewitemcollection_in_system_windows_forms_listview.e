indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListView+CheckedListViewItemCollection"

external class
	CHECKEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			prune_i_th as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			clear as system_collections_ilist_clear,
			extend as system_collections_ilist_add,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LISTVIEW) is
		external
			"IL creator signature (System.Windows.Forms.ListView) use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Boolean use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"Contains"
		end

	frozen index_of (item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Int32 use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"IndexOf"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"ToString"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (item: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+CheckedListViewItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class CHECKEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
