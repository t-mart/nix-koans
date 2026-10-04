# Late binding
#
# With `fix`, attributes refer to the final result, not to the original set.
# An update inside the function of `fix` also reaches the attributes that
# depend on the updated one. This is "late binding", and it makes nixpkgs
# customizable.
{ __ }:

let
  fix = f: let x = f x; in x;
  base = self: { a = 1; b = self.a + 1; };
in
{
  original = {
    expr = (fix base).b;
    expected = /*>*/ 2 /*<*/;
  };

  late = {
    expr = (fix (self: base self // { a = 10; })).b;
    expected = /*>*/ 11 /*<*/;
  };

  withRec = {
    expr = (rec { a = 1; b = a + 1; } // { a = 10; }).b;
    expected = /*>*/ 2 /*<*/;
  };
}
