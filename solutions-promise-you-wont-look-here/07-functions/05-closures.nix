# Closures
#
# A function remembers the names that are in scope where you write it. This
# is a "closure". The names at the place of the call have no effect. This rule
# is "lexical scope".
{ __ }:

{
  captured = {
    expr =
      let
        x = 10;
        addX = y: x + y;
      in
      addX 1;
    expected = /*>*/ 11 /*<*/;
  };

  factory = {
    expr =
      let
        makeAdder = n: m: n + m;
        add5 = makeAdder 5;
      in
      add5 1;
    expected = /*>*/ 6 /*<*/;
  };

  lexical = {
    expr =
      let
        x = 1;
        f = y: x + y;
      in
      let
        x = 100;
      in
      f 0;
    expected = /*>*/ 1 /*<*/;
  };
}
