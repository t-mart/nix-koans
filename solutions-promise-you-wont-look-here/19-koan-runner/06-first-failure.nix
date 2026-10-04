# First failure
#
# The runner finds the first failed koan with a recursive function. `||`
# stops at the end of the list, before `elemAt` goes out of range. Laziness
# means that the runner never evaluates the koans after the first failure.
{ __ }:

let
  # From default.nix, with a list of results in place of koans:
  firstFailure =
    results:
    let
      total = builtins.length results;
      go = i: if i == total || !(builtins.elemAt results i) then i else go (i + 1);
    in
    go 0;
in
{
  allPass = {
    expr = firstFailure [ true true ];
    expected = /*>*/ 2 /*<*/;
  };

  secondFails = {
    expr = firstFailure [ true false true ];
    expected = /*>*/ 1 /*<*/;
  };

  empty = {
    expr = firstFailure [ ];
    expected = /*>*/ 0 /*<*/;
  };

  lazy = {
    expr = firstFailure [ true false (throw "never evaluated") ];
    expected = /*>*/ 1 /*<*/;
  };
}
