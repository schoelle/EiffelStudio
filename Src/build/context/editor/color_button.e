class COLOR_BUTTON

inherit
	FORMAT_BUTTON

creation

	make

feature 

	symbol: PIXMAP is
		once
			Result := symbol_file_content ("color.symb")
		end

	form_number: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	focus_string: STRING is "";

end
