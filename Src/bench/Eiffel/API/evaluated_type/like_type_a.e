indexing
	description: "Representation of an anchored type"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIKE_TYPE_A

inherit
	TYPE_A
		undefine
			instantiation_in, same_as, solved_type
		redefine
			actual_type,
			conformance_type,
			convert_to,
			has_associated_class,
			has_like,
			instantiated_in,
			is_basic,
			is_expanded,
			is_external,
			is_like,
			is_loose,
			is_none,
			is_reference,
			meta_type
		end

	SHARED_LIKE_CONTROLER

feature -- Properties

	actual_type: TYPE_A
			-- Actual type of the anchored type in a given class

	conformance_type: TYPE_A is
			-- Type which is used to check conformance
		do
				-- `conformance_type' has to be called because
				-- `actual_type' may yield yet another anchored type.
			Result := actual_type.conformance_type
		end

	is_like: BOOLEAN is True
			-- Is the type anchored one ?

	has_like: BOOLEAN is True
			-- Does the type have anchored type in its definition ?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

	is_external: BOOLEAN is
			-- Is current type based on an external class?
		do
			Result := actual_type.is_external
		end

	is_reference: BOOLEAN is
			-- Is current actual type a reference one?
		do
			Result := actual_type.is_reference
		end

	is_expanded: BOOLEAN is
			-- Is current actual type an expanded one?
		do
			Result := actual_type.is_expanded
		end

	is_none: BOOLEAN is
			-- Is current actual type NONE?
		do
			Result := actual_type.is_none
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		deferred
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then
				actual_type.has_associated_class
		end

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := actual_type.associated_class
		end

feature -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a
		end

	solved_type (feat_table: FEATURE_TABLE f: FEATURE_I): like Current is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table
		deferred
		end

	instantiation_in (type: TYPE_A written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		deferred
		end

	instantiated_in (class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiated_in (class_type))
			Result := t
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does `actual_type' conform to `other'?
		do
			Result := actual_type.conform_to (other.conformance_type)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		do
			Result := actual_type.convert_to (a_context_class, a_target_type)
		end

	type_i: TYPE_I is
			-- Reduced type of `actual_type'
		local
			cl_type : CL_TYPE_I
		do
			Result := actual_type.type_i
			cl_type ?= Result

			if cl_type /= Void and then not cl_type.is_expanded then
					-- Remember that it's an anchored type, not needed
					-- when handling expanded types.
				cl_type.set_cr_info (create_info)
			end
		end

	meta_type: TYPE_I is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end

end -- class LIKE_TYPE_A
