# Safe comparison
#
# The runner compares each `expr` with its `expected` inside `tryEval`. `__`
# is a `throw`, so an unsolved koan fails without a crash. Other errors, such
# as a type error, still stop the runner.
{ __ }:

let
  placeholder = throw "Replace __ with your answer.";
  # From default.nix:
  passes =
    koan:
    let
      result = builtins.tryEval (koan.expr == koan.expected);
    in
    result.success && result.value;
in
{
  unsolved = {
    expr = passes { expr = 1; expected = placeholder; };
    expected = /*>*/ false /*<*/;
  };

  wrong = {
    expr = passes { expr = 1; expected = 2; };
    expected = /*>*/ false /*<*/;
  };

  right = {
    expr = passes { expr = 1; expected = 1.0; };
    expected = /*>*/ true /*<*/;
  };

  functions = {
    expr = passes { expr = x: x; expected = x: x; };
    expected = /*>*/ false /*<*/;
  };

  raw = {
    expr = builtins.tryEval (1 == placeholder);
    expected = /*>*/ { success = false; value = false; } /*<*/;
  };
}
