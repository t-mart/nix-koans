# Capstone: the koan runner
#
# This capstone combines the parts of the runner. After it, you can read and
# change each line of `default.nix`. You have finished the koans.
#
# Replace __ with a function `failures`. It takes a list of koans and gives
# the names of all koans that fail, not only the first.
{ __ }:

let
  placeholder = throw "Replace __ with your answer.";
  passes =
    koan:
    let
      result = builtins.tryEval (koan.expr == koan.expected);
    in
    result.success && result.value;
  koans = [
    { name = "a"; expr = 1; expected = 1; }
    { name = "b"; expr = 2; expected = placeholder; }
    { name = "c"; expr = "x"; expected = "y"; }
  ];
  failures = __;
in
{
  some = {
    expr = failures koans;
    expected = [ "b" "c" ];
  };

  none = {
    expr = failures [ ];
    expected = [ ];
  };

  report = {
    expr = builtins.concatStringsSep "\n" (failures koans);
    expected = "b\nc";
  };
}
