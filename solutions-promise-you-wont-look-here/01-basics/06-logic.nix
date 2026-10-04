# Logic
#
# `&&` is "and", `||` is "or" and `!` is "not". Nix also has the "implication"
# operator `->`: `a -> b` means "if a, then b", the same as `!a || b`. nixpkgs
# uses it to check package options, as in `assert withGui -> gtk != null;`.
{ __ }:

{
  andOperator = {
    expr = true && false;
    expected = /*>*/ false /*<*/;
  };

  orOperator = {
    expr = true || false;
    expected = /*>*/ true /*<*/;
  };

  notOperator = {
    expr = !true;
    expected = /*>*/ false /*<*/;
  };

  implicationBroken = {
    expr = true -> false;
    expected = /*>*/ false /*<*/;
  };

  implicationFromFalse = {
    expr = false -> false;
    expected = /*>*/ true /*<*/;
  };
}
