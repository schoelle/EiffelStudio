indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.UnitConverter"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_UNITCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_unitconverter

feature {NONE} -- Initialization

	frozen make_unitconverter is
		external
			"IL creator use System.Web.UI.WebControls.UnitConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Web.UI.WebControls.UnitConverter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Web.UI.WebControls.UnitConverter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Web.UI.WebControls.UnitConverter"
		alias
			"ConvertFrom"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_UNITCONVERTER
