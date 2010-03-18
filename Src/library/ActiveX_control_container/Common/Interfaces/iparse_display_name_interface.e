note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPARSE_DISPLAY_NAME_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	parse_display_name_user_precondition (pbc: IBIND_CTX_INTERFACE; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE]): BOOLEAN
			-- User-defined preconditions for `parse_display_name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	parse_display_name (pbc: IBIND_CTX_INTERFACE; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `pbc' [in].  
			-- `psz_display_name' [in].  
			-- `pch_eaten' [out].  
			-- `ppmk_out' [out].  
		require
			non_void_pch_eaten: pch_eaten /= Void
			non_void_ppmk_out: ppmk_out /= Void
			parse_display_name_user_precondition: parse_display_name_user_precondition (pbc, psz_display_name, pch_eaten, ppmk_out)
		deferred

		ensure
			valid_ppmk_out: ppmk_out.item /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IPARSE_DISPLAY_NAME_INTERFACE
