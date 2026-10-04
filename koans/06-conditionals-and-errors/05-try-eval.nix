# tryEval
#
# `builtins.tryEval e` evaluates `e` and catches a `throw`. It gives a set
# with `success` and `value`. After a `throw`, both are `false`. It does not
# catch other errors, such as type errors.
{ __ }:

{
  caught = {
    expr = builtins.tryEval (throw "boom");
    expected = __;
  };

  fine = {
    expr = builtins.tryEval 42;
    expected = __;
  };

  inBranch = {
    expr = (builtins.tryEval (if true then throw "x" else 1)).success;
    expected = __;
  };
}
