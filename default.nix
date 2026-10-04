let
  __ = throw "Replace __ with your answer.";
  lib = import <nixpkgs/lib>;
  pkgs = import <nixpkgs> { };

  numbered =
    dir:
    map (name: dir + "/${name}") (
      builtins.filter (name: builtins.match "[0-9].*" name != null) (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  call =
    file:
    let
      f = import file;
    in
    f (builtins.intersectAttrs (builtins.functionArgs f) { inherit __ lib pkgs; });

  koansIn =
    file:
    let
      set = call file;
      koan =
        name:
        set.${name}
        // {
          inherit name;
          pos = builtins.unsafeGetAttrPos "expected" set.${name};
        };
    in
    builtins.sort (a: b: a.pos.line < b.pos.line) (map koan (builtins.attrNames set));

  koans = builtins.concatMap koansIn (builtins.concatMap numbered (numbered ./koans));
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
