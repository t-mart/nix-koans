# Order
#
# `builtins.attrNames` sorts names, but the koans of a file must run in
# source order. So the runner sorts the koans of a file by the line of their
# `expected` attribute.
{ __ }:

let
  checks = {
    zebra = { expected = 1; };
    apple = { expected = 2; };
  };
  # From default.nix, simplified:
  byLine = map (koan: koan.name) (
    builtins.sort (a: b: a.pos.line < b.pos.line) (
      map (name: {
        inherit name;
        pos = builtins.unsafeGetAttrPos "expected" checks.${name};
      }) (builtins.attrNames checks)
    )
  );
in
{
  byName = {
    expr = builtins.attrNames checks;
    expected = __;
  };

  byLine = {
    expr = byLine;
    expected = __;
  };
}
