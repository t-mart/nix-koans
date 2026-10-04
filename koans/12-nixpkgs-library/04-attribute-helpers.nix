# Attribute helpers
#
# These helpers fill gaps in `builtins`. `lib.mapAttrsToList` turns a set into
# a list, and `lib.filterAttrs` keeps some attributes. `lib.genAttrs` is
# common in flakes, where it makes one output for each system.
{ __, lib }:

{
  toList = {
    expr = lib.mapAttrsToList (n: v: "${n}=${toString v}") { a = 1; b = 2; };
    expected = __;
  };

  filter = {
    expr = lib.filterAttrs (n: v: v.enable) {
      a = { enable = true; };
      b = { enable = false; };
    };
    expected = __;
  };

  generate = {
    expr = lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: "pkgs for ${system}");
    expected = __;
  };
}
