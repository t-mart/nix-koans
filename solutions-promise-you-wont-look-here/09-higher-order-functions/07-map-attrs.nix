# mapAttrs
#
# `builtins.mapAttrs f s` applies `f` to each attribute of the set `s`. The
# function gets the name and the value. NixOS code uses it to turn one set of
# settings into another.
{ __ }:

{
  double = {
    expr = builtins.mapAttrs (name: value: value * 2) { a = 1; b = 2; };
    expected = /*>*/ { a = 2; b = 4; } /*<*/;
  };

  useName = {
    expr = builtins.mapAttrs (name: value: "${name}=${value}") { x = "1"; };
    expected = /*>*/ { x = "x=1"; } /*<*/;
  };

  extract = {
    expr = builtins.mapAttrs (name: value: value.enable) {
      ssh = { enable = true; };
      nginx = { enable = false; };
    };
    expected = /*>*/ { nginx = false; ssh = true; } /*<*/;
  };
}
