note
	description: "[
		Objects representing delayed calls to a procedure.
		with some operands possibly still open.
		
		Note: Features are the same as those of ROUTINE,
			with `apply' made effective, and no further
			redefinition of `is_equal' and `copy'.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE [BASE_TYPE -> detachable ANY, OPEN_ARGS -> detachable TUPLE create default_create end]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		rename
			call as call alias "()"
		end

create {NONE}
	set_rout_disp

feature -- Calls

	apply
			-- Call procedure with `args' as last set.
		do
			call (operands)
		end

	call alias "()" (args: detachable separate OPEN_ARGS)
		local
			c: like closed_operands
			l_closed_count: INTEGER
		do
			c := closed_operands
			if c /= Void then
				l_closed_count :=  c.count
			end
			fast_call (encaps_rout_disp, calc_rout_addr, $closed_operands, $args, routine_id,
				       is_basic, written_type_id_inline_agent, l_closed_count, open_count, $open_map)
		end

feature {NONE} -- Implementation

	fast_call (a_rout_disp, a_calc_rout_addr: POINTER;
		       a_closed_operands: POINTER; a_operands: POINTER;
			   a_routine_id: INTEGER; a_is_basic: BOOLEAN; a_class_id_inline_agent: INTEGER;
			   a_closed_count, a_open_count: INTEGER; a_open_map: POINTER)
		external
			"C inline use %"eif_rout_obj.h%""
		alias
			"[
			#ifdef WORKBENCH
				if ($a_rout_disp != 0) {
					(FUNCTION_CAST(void, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
						$a_calc_rout_addr, $a_closed_operands, $a_operands);
				} else {
					rout_obj_call_procedure_dynamic (
						$a_routine_id,
						$a_is_basic,
						$a_class_id_inline_agent,
						$a_closed_operands,
						$a_closed_count,
						$a_operands,
						$a_open_count,
						$a_open_map);
				}
			#else
				(FUNCTION_CAST(void, (EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE)) $a_rout_disp)(
					$a_calc_rout_addr, $a_closed_operands, $a_operands);
			#endif
			]"
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
