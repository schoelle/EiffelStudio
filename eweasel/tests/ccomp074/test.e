class TEST

create
	make

feature

	make is
		local
			t1: TEST1 [STRING, INTEGER]
			t4: TEST4
			t5: TEST5
		do
			create t4
			create t5
			t1 := t4
			if t1.key /= t4.name then
				print ("We have a problem.%N")
			end
			t1 := t4
			if t1.item /= t4.item_name then
				print ("We have a problem.%N")
			end
		end

end
