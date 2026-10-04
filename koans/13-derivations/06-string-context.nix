# String context
#
# Nix strings carry a hidden "string context": the store paths that the
# string refers to. A string made from a derivation remembers that derivation.
# So Nix knows what a build script depends on.
{ __ }:

let
  drv = derivation { name = "hello"; system = "x86_64-linux"; builder = "/bin/sh"; };
  storeName = path: builtins.head (builtins.match "/nix/store/[a-z0-9]{32}-(.*)" path);
in
{
  plain = {
    expr = builtins.hasContext "plain text";
    expected = __;
  };

  fromDerivation = {
    expr = builtins.hasContext "${drv}";
    expected = __;
  };

  dependency = {
    expr = map storeName (builtins.attrNames (builtins.getContext "${drv}/bin/hello"));
    expected = __;
  };

  outputs = {
    expr = builtins.attrValues (builtins.getContext "${drv}");
    expected = __;
  };
}
