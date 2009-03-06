note
	description: "[
		Example implementation of how to generate code with {SERV_ELMENT}s
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_GEN_APPLICATION

create
	make

feature -- Access

	make
		-- for testing
		local
			servlet: ROOT_SERVLET_ELEMENT
			oe: PLAIN_XHTML_ELEMENT
			name: STRING
			controller_name: STRING
			call: CALL_ELEMENT
			op_call: OUTPUT_CALL_ELEMENT
			gen: WEBAPP_GENERATOR
		do
			name := "hello_world"
			controller_name := "MY_CONTROLLER"
			create {ROOT_SERVLET_ELEMENT} servlet.make (name, controller_name)
			create oe.make ("<html><body /> </html>")
			create op_call.make ("return_something")
			create call.make ("do_something")
			servlet.put_xhtml_elements (oe)
			servlet.put_xhtml_elements (call)
			servlet.put_xhtml_elements (op_call)

			create gen.make ("my_web_app", "code_gen/generated/")
			gen.put_servlet (servlet)
			gen.generate
		end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
