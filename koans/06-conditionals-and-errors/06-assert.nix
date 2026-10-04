# assert
#
# `assert c; e` gives `e` when `c` is true. Otherwise, evaluation fails like a
# `throw`. nixpkgs uses it to check package options, as in
# `assert withGui -> gtk != null;`.
{ __ }:

{
  passes = {
    expr = assert 1 < 2; "ok";
    expected = __;
  };

  fails = {
    expr = builtins.tryEval (assert 1 > 2; "ok");
    expected = __;
  };

  implication = {
    expr = (builtins.tryEval (assert true -> false; 1)).success;
    expected = __;
  };
}
