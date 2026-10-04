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
    expected = __;
  };

  secondFails = {
    expr = firstFailure [ true false true ];
    expected = __;
  };

  empty = {
    expr = firstFailure [ ];
    expected = __;
  };

  lazy = {
    expr = firstFailure [ true false (throw "never evaluated") ];
    expected = __;
  };
}
