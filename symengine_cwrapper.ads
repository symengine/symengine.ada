with System;
with Interfaces.C;
use Interfaces.C;
with Interfaces.C.Strings;
use Interfaces.C.Strings;


package symengine_cwrapper is

   subtype cptr is System.Address;

   function basic_new_heap return cptr
   with Import => True,
        Convention => C,
        External_Name => "basic_new_heap";

   procedure basic_free_heap(s : cptr)
   with Import => True,
        Convention => C,
        External_Name => "basic_free_heap";

   function basic_assign(a : cptr; b : cptr) return long
   with Import => True,
        Convention => C,
        External_Name => "basic_assign";

    function basic_add(s : cptr; a : cptr; b : cptr) return long
    with Import => True,
         Convention => C,
         External_Name => "basic_add";

    function basic_sub(s : cptr; a : cptr; b : cptr) return long
    with Import => True,
         Convention => C,
         External_Name => "basic_sub";

    function basic_mul(s : cptr; a : cptr; b : cptr) return long
    with Import => True,
         Convention => C,
         External_Name => "basic_mul";

    function basic_div(s : cptr; a : cptr; b : cptr) return long
    with Import => True,
         Convention => C,
         External_Name => "basic_div";

    function basic_pow(s : cptr; a : cptr; b : cptr) return long
    with Import => True,
         Convention => C,
         External_Name => "basic_pow";

    procedure basic_const_pi(s : cptr)
    with Import => True,
        Convention => C,
        External_Name => "basic_const_pi";

    procedure basic_const_e(s : cptr)
    with Import => True,
        Convention => C,
        External_Name => "basic_const_E";

    function basic_abs(s : cptr; a : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_abs";
 
    function basic_log(s : cptr; a : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_log";
 
    function basic_exp(s : cptr; a : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_exp";

    function basic_sin(s : cptr; a : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_sin";
    
    function basic_cos(s : cptr; a : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_cos";

    function basic_tan(s : cptr; a : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_tan";

    function basic_atan2(s : cptr; a : cptr; b : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_atan2";
    
    function basic_eq(a, b : cptr) return int
    with Import => True,
        Convention => C,
        External_Name => "basic_eq";

    function basic_max(s : cptr; d : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_max";

    function basic_min(s : cptr; d : cptr) return long
    with Import => True,
        Convention => C,
        External_Name => "basic_min";

    function basic_str(s : cptr) return chars_ptr
    with Import => True,
         Convention => C,
         External_Name => "basic_str";

    procedure basic_str_free(s : chars_ptr)
    with Import => True,
         Convention => C,
         External_Name => "basic_str_free";

   function basic_parse(b : cptr; str : chars_ptr) return long
   with Import => True, 
        Convention => C, 
        External_Name => "basic_parse";

   function integer_set_si(s : cptr; i : long) return long
   with Import => True, 
        Convention => C, 
        External_Name => "integer_set_si";

   function rational_set_si(s : cptr; a, b : long) return long
   with Import => True, 
        Convention => C, 
        External_Name => "rational_set_si";

   function real_double_set_d(s : cptr; d : double) return long
   with Import => True, 
        Convention => C, 
        External_Name => "real_double_set_d";

   function symbol_set(s : cptr; c : chars_ptr) return long
   with Import => True, 
        Convention => C, 
        External_Name => "symbol_set";
   
   function vecbasic_new return cptr 
   with Import => True, 
        Convention => C, 
        External_Name => "vecbasic_new";
   
   procedure vecbasic_free(self : cptr)
   with Import => True, 
        Convention => C, 
        External_Name => "vecbasic_free";
   
   function vecbasic_push_back(self : cptr; value : cptr) return long
   with Import => True, 
        Convention => C, 
        External_Name => "vecbasic_push_back";

end symengine_cwrapper;
