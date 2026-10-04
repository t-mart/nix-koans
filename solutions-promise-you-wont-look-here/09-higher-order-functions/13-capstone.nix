# Capstone: higher-order functions
#
# This capstone combines `map`, `filter` and `listToAttrs`. NixOS code does
# such transformations to turn user settings into configuration files.
#
# Replace __ with an expression. It must give a set from the name to the
# version of each package in `packages` that has `enable = true`.
{ __ }:

let
  packages = [
    { name = "git"; enable = true; version = "2.45"; }
    { name = "vim"; enable = false; version = "9.1"; }
    { name = "jq"; enable = true; version = "1.7"; }
  ];
  enabledByName = /*>*/ builtins.listToAttrs (map (p: { name = p.name; value = p.version; }) (builtins.filter (p: p.enable) packages)) /*<*/;
in
{
  result = {
    expr = enabledByName;
    expected = { git = "2.45"; jq = "1.7"; };
  };
}
