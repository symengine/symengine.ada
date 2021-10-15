with Ada.Text_IO;
use Ada.Text_IO;

with symengine;
use symengine;

procedure Test is

    procedure assert(a : Basic'Class; s : string) is
        test_fail : exception;
    begin
        if str(a) /= s then
            raise test_fail with str(a) & " /= " & s;
        end if;
    end assert;

    procedure assert(a : Boolean) is
        test_fail : exception;
    begin
        if not a then
            raise test_fail;
        end if;
    end assert;

    a : Basic;
    b : Basic;
    c : Basic;
    x : Basic;
begin
    a := Basic(new_integer(23));
    assert(a, "23");

    b := Basic(new_integer(-2));
    
    a := a + b;
    assert(a, "21");

    a := b + 111;
    assert(a, "109");

    a := 111 + b;
    assert(a, "109");

    a := b + 3.0;
    assert(a, "1.0");

    a := 3.0 + b;
    assert(a, "1.0");

    a := +b;
    assert(a, "-2");

    a := b * b;
    assert(a, "4");

    a := b * 111;
    assert(a, "-222");

    a := 111 * b;
    assert(a, "-222");

    a := b * 2.0;
    assert(a, "-4.0");

    a := 2.0 * b;
    assert(a, "-4.0");

    b := Basic(new_integer(4));
    c := Basic(new_integer(2));
    a := b / c;
    assert(a, "2");
    a := b / 2;
    assert(a, "2");
    a := 2 / b;
    assert(a, "1/2");
    a := b / 2.0;
    assert(a, "2.0");
    a := 2.0 / b;
    assert(a, "0.5");

    b := Basic(new_integer(4));
    c := Basic(new_integer(2));
    a := b - c;
    assert(a, "2");
    a := b - 2;
    assert(a, "2");
    a := 2 - b;
    assert(a, "-2");
    a := b - 2.0;
    assert(a, "2.0");
    a := 2.0 - b;
    assert(a, "-2.0");
    a := -b;
    assert(a, "-4");

    b := Basic(new_integer(4));
    c := Basic(new_integer(2));
    a := b ** c;
    assert(a, "16");
    a := b ** 2;
    assert(a, "16");
    a := 2 ** b;
    assert(a, "16");
    a := b ** 2.0;
    assert(a, "16.0");
    a := 2.0 ** b;
    assert(a, "16.0");

    b := Basic(new_symbol("x"));
    c := Basic(new_integer(2));
    a := b * c;
    assert(a, "2*x");

    b := Basic(new_rational(3, 4));
    assert(b, "3/4");

    b := Basic(new_real_double(1.25));
    assert(b, "1.25");

    a := pi;
    assert(a, "pi");
    a := e;
    assert(a, "E");

    x := Basic(new_symbol("x"));
    a := abs(-x);
    assert(a, "abs(x)");
    a := log(x);
    assert(a, "log(x)");
    a := exp(x);
    assert(a, "exp(x)");
    a := sin(x);
    assert(a, "sin(x)");
    a := cos(x);
    assert(a, "cos(x)");
    a := tan(x);
    assert(a, "tan(x)");

    a := atan2(x, x);
    assert(a, "(1/4)*pi");

    a := max((x, Basic(new_integer(1))));
    assert(a, "max(1, x)");

    a := min((x, Basic(new_integer(1))));
    assert(a, "min(1, x)");

    a := parse("x + 1");
    assert(a, "1 + x");

    assert(x = x);
end Test;
