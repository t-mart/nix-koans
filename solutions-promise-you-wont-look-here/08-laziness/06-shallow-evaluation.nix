# Shallow evaluation
#
# Nix evaluates a value only to its outer layer, the "weak head normal form".
# `builtins.seq a b` evaluates the outer layer of `a`, then gives `b`.
# `builtins.deepSeq` evaluates all layers. `tryEval` catches only errors in
# the outer layer.
{ __ }:

{
  seq = {
    expr = builtins.seq { a = throw "boom"; } "done";
    expected = /*>*/ "done" /*<*/;
  };

  tryEvalSet = {
    expr = (builtins.tryEval { a = throw "boom"; }).success;
    expected = /*>*/ true /*<*/;
  };

  tryEvalList = {
    expr = (builtins.tryEval [ (throw "boom") ]).success;
    expected = /*>*/ true /*<*/;
  };

  deepSeq = {
    expr = (builtins.tryEval (builtins.deepSeq { a = throw "boom"; } "done")).success;
    expected = /*>*/ false /*<*/;
  };
}
