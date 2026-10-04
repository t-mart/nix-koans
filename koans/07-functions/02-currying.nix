# Currying
#
# Every Nix function takes exactly one argument. A function of two arguments
# is a function that gives another function. This is "currying". A call with
# only the first argument is a "partial application".
{ __ }:

{
  twoArguments = {
    expr =
      let
        add = a: b: a + b;
      in
      add 1 2;
    expected = __;
  };

  partial = {
    expr =
      let
        add = a: b: a + b;
        inc = add 1;
      in
      inc 41;
    expected = __;
  };

  threeArguments = {
    expr =
      let
        join = sep: a: b: a + sep + b;
      in
      join ", " "x" "y";
    expected = __;
  };

  partialType = {
    expr = builtins.typeOf ((a: b: a) 1);
    expected = __;
  };
}
