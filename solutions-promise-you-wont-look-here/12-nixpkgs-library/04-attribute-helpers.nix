# Attribute helpers
#
# These helpers fill gaps in `builtins`. `lib.mapAttrsToList` turns a set into
# a list, and `lib.filterAttrs` keeps some attributes. `lib.genAttrs` is
# common in flakes, where it makes one output for each system.
{ __, lib }:

{
  toList = {
    expr = lib.mapAttrsToList (n: v: "${n}=${toString v}") { a = 1; b = 2; };
    expected = /*>*/ [ "a=1" "b=2" ] /*<*/;
  };

  filter = {
    expr = lib.filterAttrs (n: v: v.enable) {
      a = { enable = true; };
      b = { enable = false; };
    };
    expected = /*>*/ { a = { enable = true; }; } /*<*/;
  };

  generate = {
    expr = lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: "pkgs for ${system}");
    expected = /*>*/ {
      aarch64-linux = "pkgs for aarch64-linux";
      x86_64-linux = "pkgs for x86_64-linux";
    } /*<*/;
  };
}
