indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.EiffelCodeGenerator"

external class
	ISE_REFLECTION_EIFFELCODEGENERATOR

inherit
	ISE_REFLECTION_EIFFELCODEGENERATORDICTIONARY

create
	make_eiffelcodegenerator

feature {NONE} -- Initialization

	frozen make_eiffelcodegenerator is
		external
			"IL creator use ISE.Reflection.EiffelCodeGenerator"
		end

feature -- Access

	frozen EiffelAssembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelCodeGenerator"
		alias
			"EiffelAssembly"
		end

	frozen GeneratedCode: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GeneratedCode"
		end

	frozen SpecialClasses: ARRAY [STRING] is
		external
			"IL field signature :System.String[] use ISE.Reflection.EiffelCodeGenerator"
		alias
			"SpecialClasses"
		end

	frozen Parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.EiffelCodeGenerator"
		alias
			"Parents"
		end

	frozen EiffelClass: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.EiffelCodeGenerator"
		alias
			"EiffelClass"
		end

feature -- Basic Operations

	GenerateEiffelFeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelFeature"
		end

	HasAnyRename: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyRename"
		end

	GenerateCreateClause is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateCreateClause"
		end

	IsSpecialClass: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"IsSpecialClass"
		end

	HasAnyRedefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyRedefine"
		end

	GenerateClassFeatures is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateClassFeatures"
		end

	GenerateEiffelClassFromPath (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; a_path: STRING) is
		external
			"IL signature (ISE.Reflection.EiffelClass, System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelClassFromPath"
		end

	GenerateInheritClause is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateInheritClause"
		end

	MakeFromInfo (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"MakeFromInfo"
		end

	MakeEiffelCodeGenerator is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"MakeEiffelCodeGenerator"
		end

	HasAnyUndefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyUndefine"
		end

	InternGenerateClassFeatures (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"InternGenerateClassFeatures"
		end

	GenerateFeatureAssertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; keyword: STRING) is
		external
			"IL signature (System.Collections.ArrayList, System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateFeatureAssertions"
		end

	InternGenerateEiffelClass (a_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"InternGenerateEiffelClass"
		end

	GenerateExternalClause (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateExternalClause"
		end

	GenerateEiffelClass (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelClass"
		end

	GenerateInheritanceClauses (clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateInheritanceClauses"
		end

	FeatureSignature (a_feature: ISE_REFLECTION_EIFFELFEATURE): STRING is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.String use ISE.Reflection.EiffelCodeGenerator"
		alias
			"FeatureSignature"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATOR
