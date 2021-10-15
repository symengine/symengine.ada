with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Interfaces.C;
use Interfaces.C;
with symengine_cwrapper;
use symengine_cwrapper;
with Interfaces.C.Strings;
use Interfaces.C.Strings;


package body symengine is

    procedure Initialize(self : in out Basic) is
    begin
        self.ptr := basic_new_heap;
    end Initialize;

    procedure Adjust(self : in out Basic) is
        copy : cptr := basic_new_heap;
        ex : long;
    begin
        ex := basic_assign(copy, self.ptr);
        self.ptr := copy;
    end Adjust;

    procedure Finalize(self : in out Basic) is
    begin
        basic_free_heap(self.ptr);
    end Finalize;

    procedure handle_exception(ex : long) is
    begin
        case ex is
            when 1 =>
                raise SymEngineException with "Runtime Error";
            when 2 =>
                raise SymEngineException with "Division by Zero";
            when 3 =>
                raise SymEngineException with "Not implemented";
            when 4 =>
                raise SymEngineException with "Domain Error";
            when 5 =>
                raise SymEngineException with "Parse Error";
            when others => 
                null;
        end case;
    end handle_exception;

    function to_vecbasic(x : BasicArray) return cptr is
        a : cptr;
        ex : long;
    begin
        a := vecbasic_new;
        for i in x'Range loop
            ex := vecbasic_push_back(a, x(i).ptr);
            handle_exception(ex);
        end loop;
        return a; 
    end to_vecbasic;

    function "=" (left, right : Basic'Class) return Boolean is
        a : int;
    begin
        a := basic_eq(left.ptr, right.ptr);
        return a /= 0;
    end "=";

    function "+" (left, right : Basic'Class) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_add(res.ptr, left.ptr, right.ptr);
        handle_exception(ex);
        return res;
    end "+";

    function "+" (left : Basic'Class; right : Integer) return Basic is
        temp : SymInteger := new_integer(right);
    begin
        return left + temp; 
    end "+";

    function "+" (left : Integer; right : Basic'Class) return Basic is
        temp : SymInteger := new_integer(left);
    begin
        return temp + right; 
    end "+";

    function "+" (left : Basic'Class; right : Float) return Basic is
        temp : RealDouble := new_real_double(right);
    begin
        return left + temp; 
    end "+";

    function "+" (left : Float; right : Basic'Class) return Basic is
        temp : RealDouble := new_real_double(left);
    begin
        return temp + right; 
    end "+";

    function "+" (right : Basic'Class) return Basic is
    begin
        return Basic(right); 
    end "+";

    function "-" (left, right : Basic'Class) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_sub(res.ptr, left.ptr, right.ptr);
        handle_exception(ex);
        return res;
    end "-";

    function "-" (left : Basic'Class; right : Integer) return Basic is
        temp : SymInteger := new_integer(right);
    begin
        return left - temp; 
    end "-";

    function "-" (left : Integer; right : Basic'Class) return Basic is
        temp : SymInteger := new_integer(left);
    begin
        return temp - right; 
    end "-";

    function "-" (left : Basic'Class; right : Float) return Basic is
        temp : RealDouble := new_real_double(right);
    begin
        return left - temp; 
    end "-";

    function "-" (left : Float; right : Basic'Class) return Basic is
        temp : RealDouble := new_real_double(left);
    begin
        return temp - right; 
    end "-";

    function "-" (right : Basic'Class) return Basic is
        zero : SymInteger := new_integer(0);
    begin
        return zero - right; 
    end "-";

    function "*" (left, right : Basic'Class) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_mul(res.ptr, left.ptr, right.ptr);
        handle_exception(ex);
        return res;
    end "*";

    function "*" (left : Basic'Class; right : Integer) return Basic is
        temp : SymInteger := new_integer(right);
    begin
        return left * temp; 
    end "*";

    function "*" (left : Integer; right : Basic'Class) return Basic is
        temp : SymInteger := new_integer(left);
    begin
        return temp * right; 
    end "*";

    function "*" (left : Basic'Class; right : Float) return Basic is
        temp : RealDouble := new_real_double(right);
    begin
        return left * temp; 
    end "*";

    function "*" (left : Float; right : Basic'Class) return Basic is
        temp : RealDouble := new_real_double(left);
    begin
        return temp * right; 
    end "*";

    function "/" (left, right : Basic'Class) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_div(res.ptr, left.ptr, right.ptr);
        handle_exception(ex);
        return res;
    end "/";

    function "/" (left : Basic'Class; right : Integer) return Basic is
        temp : SymInteger := new_integer(right);
    begin
        return left / temp; 
    end "/";

    function "/" (left : Integer; right : Basic'Class) return Basic is
        temp : SymInteger := new_integer(left);
    begin
        return temp / right; 
    end "/";

    function "/" (left : Basic'Class; right : Float) return Basic is
        temp : RealDouble := new_real_double(right);
    begin
        return left / temp; 
    end "/";

    function "/" (left : Float; right : Basic'Class) return Basic is
        temp : RealDouble := new_real_double(left);
    begin
        return temp / right; 
    end "/";

    function "**" (left, right : Basic'Class) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_pow(res.ptr, left.ptr, right.ptr);
        handle_exception(ex);
        return res;
    end "**";

    function "**" (left : Basic'Class; right : Integer) return Basic is
        temp : SymInteger := new_integer(right);
    begin
        return left ** temp; 
    end "**";

    function "**" (left : Integer; right : Basic'Class) return Basic is
        temp : SymInteger := new_integer(left);
    begin
        return temp ** right; 
    end "**";

    function "**" (left : Basic'Class; right : Float) return Basic is
        temp : RealDouble := new_real_double(right);
    begin
        return left ** temp; 
    end "**";

    function "**" (left : Float; right : Basic'Class) return Basic is
        temp : RealDouble := new_real_double(left);
    begin
        return temp ** right; 
    end "**";

    function pi return Basic is
        res : Basic;
    begin
        basic_const_pi(res.ptr);
        return res;
    end pi;

    function e return Basic is
        res : Basic;
    begin
        basic_const_e(res.ptr);
        return res;
    end e;

    function "abs"(x : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_abs(res.ptr, x.ptr);
        handle_exception(ex);
        return res;
    end "abs";

    function log(x : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_log(res.ptr, x.ptr);
        handle_exception(ex);
        return res;
    end log;

    function exp(x : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_exp(res.ptr, x.ptr);
        handle_exception(ex);
        return res;
    end exp;

    function sin(x : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_sin(res.ptr, x.ptr);
        handle_exception(ex);
        return res;
    end sin;

    function cos(x : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_cos(res.ptr, x.ptr);
        handle_exception(ex);
        return res;
    end cos;

    function tan(x : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_tan(res.ptr, x.ptr);
        handle_exception(ex);
        return res;
    end tan;

    function atan2(x, y : Basic) return Basic is
        res : Basic;
        ex : long;
    begin
        ex := basic_atan2(res.ptr, x.ptr, y.ptr);
        handle_exception(ex);
        return res;
    end atan2;

    function max(a : BasicArray) return Basic is
        ex : long;
        vec : cptr;
        res : Basic;
    begin
        vec := to_vecbasic(a);
        ex := basic_max(res.ptr, vec);
        vecbasic_free(vec);
        handle_exception(ex);
        return res;
    end max;

    function min(a : BasicArray) return Basic is
        ex : long;
        vec : cptr;
        res : Basic;
    begin
        vec := to_vecbasic(a);
        ex := basic_min(res.ptr, vec);
        vecbasic_free(vec);
        handle_exception(ex);
        return res;
    end min;

    function str(self : Basic) return String is
        sp : chars_ptr := basic_str(self.ptr);
        s : string := Value(sp);
    begin
        basic_str_free(sp);
        return s;
    end str;

    function parse(str : String) return Basic is
        cstr : chars_ptr;
        s : Basic;
        ex : long;
    begin
        cstr := New_String(str);
        ex := basic_parse(s.ptr, cstr);
        Free(cstr);
        handle_exception(ex);
        return s;
    end parse;

    function new_integer(x : Integer) return SymInteger is
        n : SymInteger;
        ex : long;
    begin
        ex := integer_set_si(n.ptr, long(x));
        handle_exception(ex);
        return n;
    end new_integer;

    function new_rational(a, b : Integer) return Rational is
        n : Rational;
        ex : long;
    begin
        ex := rational_set_si(n.ptr, long(a), long(b));
        handle_exception(ex);
        return n;
    end new_rational;

    function new_real_double(x : Float) return RealDouble is
        n : RealDouble;
        ex : long;
    begin
        ex := real_double_set_d(n.ptr, double(x));
        handle_exception(ex);
        return n;
    end new_real_double;

    function new_symbol(s : String) return Symbol is
        cstr : chars_ptr;
        sym : Symbol;
        ex : long;
    begin
        cstr := New_String(s);
        ex := symbol_set(sym.ptr, cstr);
        Free(cstr);
        handle_exception(ex);
        return sym;
    end new_symbol;

end symengine;
