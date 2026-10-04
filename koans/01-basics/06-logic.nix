# Logic
#
# `&&` is "and", `||` is "or" and `!` is "not". Nix also has the "implication"
# operator `->`: `a -> b` means "if a, then b", the same as `!a || b`. nixpkgs
# uses it to check package options, as in `assert withGui -> gtk != null;`.
{ __ }:

{
  andOperator = {
    expr = true && false;
    expected = __;
  };

  orOperator = {
    expr = true || false;
    expected = __;
  };

  notOperator = {
    expr = !true;
    expected = __;
  };

  implicationBroken = {
    expr = true -> false;
    expected = __;
  };

  implicationFromFalse = {
    expr = false -> false;
    expected = __;
  };
}
