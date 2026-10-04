let
  __ = throw "Replace __ with your answer.";

  dir = ./koans;

  files = builtins.filter (name: builtins.match "[0-9].*\\.nix" name != null) (
    builtins.attrNames (builtins.readDir dir)
  );

  koansIn =
    file:
    let
      set = import (dir + "/${file}") { inherit __; };
      koan =
        name:
        set.${name}
        // {
          inherit name;
          pos = builtins.unsafeGetAttrPos "expected" set.${name};
        };
    in
    builtins.sort (a: b: a.pos.line < b.pos.line) (map koan (builtins.attrNames set));

  koans = builtins.concatMap koansIn files;
  total = builtins.length koans;

  passes =
    koan:
    let
      result = builtins.tryEval (koan.expr == koan.expected);
    in
    result.success && result.value;

  firstFailure =
    i: if i == total || !passes (builtins.elemAt koans i) then i else firstFailure (i + 1);

  passed = firstFailure 0;
  koan = builtins.elemAt koans passed;
in
if passed == total then
  "All ${toString total} koans pass.\n"
else
  ''
    Progress: ${toString passed}/${toString total}
    Meditate on ${koan.pos.file}:${toString koan.pos.line} (${koan.name})
  ''
