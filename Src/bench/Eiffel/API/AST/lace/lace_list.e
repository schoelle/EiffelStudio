-- List used in abstract syntax trees.

class LACE_LIST [T->AST_LACE]

inherit

	AST_LACE
		undefine 
			pass_address, copy, setup, consistent, is_equal
		redefine
			adapt
		end;
	CONSTRUCT_LIST [T]

creation

	make

feature

	adapt is
			-- Adaptation iteration
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := count;
			until
				i > nb
			loop
				i_th (i).adapt;
				i := i + 1
			end
		end

end
