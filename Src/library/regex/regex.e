

note

   library: "Eif rx"
   type: "regular expressions"
   description: "A compiled regular expression which matches can be %
                %made against.  A wrapper around GNU rx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
   copyright: "Bruce Wielinga (1997)"
   licence: "GPL version 2, see LICENCE"

class

   REGEX

inherit
	DISPOSABLE

create {REGEX_COMPILER}

   make

feature
   -- matching strings

   match( str: STRING)
	 -- match expression against `str'
      require
	 str /= Void
      local
	 tmp_ptr: POINTER
	 mat_suc: INTEGER
	 a: ANY
      do
	  a ?= str.to_c
	 mat_suc := bw_match( reg, $a,
			     count + 1, reg_match,
			     reg_notbol,reg_noteol)
	 if mat_suc =  0 then 
	    succeeded := true
	    match_string := clone(str)
	 else
	    check mat_suc /= Reg_espace end
	    -- if out of memory
	    check mat_suc = Reg_nomatch end
	    -- this should be only other possible return value
	    succeeded := false
	 end
      end

     match_string: STRING 
     -- last string  match done against

     succeeded: BOOLEAN 
     -- did the last match succed?

feature
   -- flags controlling matches

   beginning_of_line: BOOLEAN 
	 -- should the beginning of the match_string be counted as 
	 -- the beginning of a line?

   set_beginning_of_line
	 -- set `beginning_of_line' to true
      do
	 beginning_of_line := True
      ensure
	 beginning_of_line
      end

   unset_beginning_of_line
	 -- set `beginning_of_line' to false
      do
	 beginning_of_line := False
      ensure
	 not beginning_of_line 
      end

   end_of_line: BOOLEAN 
	 -- should the end of the match_string be counted as 
	 -- the end of a line?

   set_end_of_line
	 -- set `end_of_line' to true
      do
	 end_of_line := True
      ensure
	 end_of_line
      end

   unset_end_of_line
	 -- set `end_of_line' to false
      do
	 end_of_line := False
      ensure
	 not end_of_line 
      end

feature {NONE}
   -- implimenting flags

   Reg_bol: INTEGER = 1

   Reg_eol: INTEGER = 2

   reg_notbol: INTEGER
	 -- value of `REG_NOTBOL' flag
      do
	 if not beginning_of_line then
	    Result := Reg_bol
	 else
	    Result := 0
	 end
      ensure
	 Result = 0 or Result = Reg_bol
      end

  reg_noteol: INTEGER
	 -- value of `REG_NOTEOL' flag
      do
	 if not end_of_line then
	    Result := Reg_eol
	 else
	    Result := 0
	 end
      ensure
	 Result = 0 or Result = Reg_eol
      end

feature 
   -- substrings

     count: INTEGER
     -- the number of potential sub expressions
     
     valid_index( i: INTEGER): BOOLEAN
	 -- is `i' a valid substring index?
      do
	 Result := (i>=0) and (i <= count)
      ensure
	 Result = ((i>=0) and (i <= count))
      end

   lower( i: INTEGER): INTEGER
	 -- lower index of `i' th substring
      require
	 valid_index(i)
	 succeeded
      do
	 Result := bw_start_offset(reg_match, i) + 1
      ensure
	 match_string.valid_index(Result )
      end

   upper( i: INTEGER): INTEGER
	 -- upper index of `i' th substring
      require
	 valid_index(i)
	 succeeded
      do
	 Result := bw_end_offset( reg_match, i) 
      ensure
	 match_string.valid_index(Result )
      end

   item( i: INTEGER): STRING
	 -- `i' th matching substring
      require
	 valid_index(i)
	 succeeded
      do
	 Result :=  match_string.substring(lower(i),upper(i))
      ensure
	 Result /= Void
      end

feature
   -- disposal

   dispose
	 -- action just before gc
      do
	bw_free_reg_space(reg)
	bw_free_subarray(reg_match)
      end


feature {NONE}
   -- creation

   make( int_reg: POINTER)
	 -- create a regular expression based on `int_reg'
      require
	  int_reg /= Default_pointer
      do
	 reg := int_reg
	 count := bw_re_nsub(reg)
	 reg_match := bw_alloc_subarray(count)
      end

feature {NONE}
   -- pointers to c structures

   reg: POINTER
	 -- the compiled regular expression

   reg_match: POINTER
	 -- the place the matchs go

feature {NONE}
   -- external c code

   Reg_espace: INTEGER = 12

   Reg_nomatch: INTEGER = 1

   bw_match( r:  POINTER; s: POINTER; nmat: INTEGER; p: POINTER; fl_b: INTEGER;
	     fl_e: INTEGER): INTEGER
	 -- attempt to match `r' against `s'
      require
	 r /= Default_pointer
	 s /= Default_pointer
      external "C ( regex_t*,char*, int, regmatch_t*, int, int): int | %"regex_glue.h%""
      end

   bw_re_nsub( r: POINTER): INTEGER
	 -- how many subexpreesions might match?
      require
	 r /= Default_pointer
      external "C (regex_t*): int | %"regex_glue.h%""
      end

   bw_free_reg_space( r: POINTER)
	 -- free space used by `r'
      require
	 r /= Default_pointer
      external "C (regext_t*) | %"regex_glue.h%""
      end

   bw_alloc_subarray( i: INTEGER): POINTER
	 -- allocates an array of subexpression match structures
      require
	 i >= 0
      external "C (int): regmatch_t* | %"regex_glue.h%""
      end

   bw_free_subarray( p: POINTER)
	 -- frees allocated pointer
      require
	 p /= Default_pointer
      external "C (regmatch_t*) | %"regex_glue.h%""
      end

   bw_start_offset( p: POINTER; i: INTEGER): INTEGER
	 -- index of start of `i' th matching substring
      require
	 p /= Default_pointer 
	 valid_index( i )
      external "C (regmatch_t*, int): int | %"regex_glue.h%""
      end

   bw_end_offset( p: POINTER; i: INTEGER): INTEGER
	 -- index of end of `i' th matching substring
      require
	 p /= Default_pointer
	 valid_index(i)
      external  "C (regmatch_t*, int): int | %"regex_glue.h%""
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




end
