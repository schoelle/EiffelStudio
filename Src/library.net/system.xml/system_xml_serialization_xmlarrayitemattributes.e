indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlArrayItemAttributes"

external class
	SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTES

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			extend as system_collections_ilist_add,
			has as system_collections_ilist_contains,
			put_i_th as system_collections_ilist_set_item,
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
	make_xmlarrayitemattributes

feature {NONE} -- Initialization

	frozen make_xmlarrayitemattributes is
		external
			"IL creator use System.Xml.Serialization.XmlArrayItemAttributes"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE is
		external
			"IL signature (System.Int32): System.Xml.Serialization.XmlArrayItemAttribute use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlArrayItemAttribute): System.Void use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: ARRAY [SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE]; index: INTEGER) is
		external
			"IL signature (System.Xml.Serialization.XmlArrayItemAttribute[], System.Int32): System.Void use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"CopyTo"
		end

	frozen contains (attribute: SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Xml.Serialization.XmlArrayItemAttribute): System.Boolean use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"Contains"
		end

	frozen index_of (attribute: SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlArrayItemAttribute): System.Int32 use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"IndexOf"
		end

	frozen add (attribute: SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlArrayItemAttribute): System.Int32 use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"Add"
		end

	frozen remove (attribute: SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlArrayItemAttribute): System.Void use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; attribute: SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlArrayItemAttribute): System.Void use System.Xml.Serialization.XmlArrayItemAttributes"
		alias
			"Insert"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTES
