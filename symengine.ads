with Ada.Finalization;
with symengine_cwrapper;
use symengine_cwrapper;

package symengine is

    type Basic is tagged private;
    type BasicArray is array (Positive range <>) of Basic;
    type SymInteger is new Basic with private;
    type Rational is new Basic with private;
    type RealDouble is new Basic with private;
    type Symbol is new Basic with private;

    SymEngineException : exception;

    procedure Initialize(self : in out Basic);
    procedure Adjust(self : in out Basic);
    procedure Finalize(self : in out Basic);
    function str(self : Basic) return String;
    function parse(str : string) return Basic;
    function "=" (left, right : Basic'Class) return Boolean;
    function "+" (left, right : Basic'Class) return Basic;
    function "+" (left : Basic'Class; right : Integer) return Basic;
    function "+" (left : Integer; right : Basic'Class) return Basic;
    function "+" (left : Basic'Class; right : Float) return Basic;
    function "+" (left : Float; right : Basic'Class) return Basic;
    function "+" (right : Basic'Class) return Basic;
    function "-" (left, right : Basic'Class) return Basic;
    function "-" (left : Basic'Class; right : Integer) return Basic;
    function "-" (left : Integer; right : Basic'Class) return Basic;
    function "-" (left : Basic'Class; right : Float) return Basic;
    function "-" (left : Float; right : Basic'Class) return Basic;
    function "-" (right : Basic'Class) return Basic;
    function "*" (left, right : Basic'Class) return Basic;
    function "*" (left : Basic'Class; right : Integer) return Basic;
    function "*" (left : Integer; right : Basic'Class) return Basic;
    function "*" (left : Basic'Class; right : Float) return Basic;
    function "*" (left : Float; right : Basic'Class) return Basic;
    function "/" (left, right : Basic'Class) return Basic;
    function "/" (left : Basic'Class; right : Integer) return Basic;
    function "/" (left : Integer; right : Basic'Class) return Basic;
    function "/" (left : Basic'Class; right : Float) return Basic;
    function "/" (left : Float; right : Basic'Class) return Basic;
    function "**" (left, right : Basic'Class) return Basic;
    function "**" (left : Basic'Class; right : Integer) return Basic;
    function "**" (left : Integer; right : Basic'Class) return Basic;
    function "**" (left : Basic'Class; right : Float) return Basic;
    function "**" (left : Float; right : Basic'Class) return Basic;
    function "abs"(x : Basic) return Basic;

    function pi return Basic;
    function e return Basic;

    function log(x : Basic) return Basic;
    function exp(x : Basic) return Basic;
    function sin(x : Basic) return Basic;
    function cos(x : Basic) return Basic;
    function tan(x : Basic) return Basic;
    function atan2(x, y : Basic) return Basic;
    function max(a : BasicArray) return Basic;
    function min(a : BasicArray) return Basic;

    function new_integer(x : Integer) return SymInteger;
    function new_rational(a, b : Integer) return Rational;
    function new_real_double(x : Float) return RealDouble;
    function new_symbol(s : String) return Symbol;

private

    type Basic is new Ada.Finalization.Controlled with record
        ptr : cptr;
    end record;
    type SymInteger is new Basic with null record;
    type Rational is new Basic with null record;
    type RealDouble is new Basic with null record;
    type Symbol is new Basic with null record;

end symengine;
