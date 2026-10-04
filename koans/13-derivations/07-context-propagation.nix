# Context propagation
#
# The result of a string function keeps the context of its inputs. Even a
# short substring of a store path still refers to the derivation. So a
# dependency survives any string operation in a build script.
{ __ }:

let
  drv = derivation { name = "hello"; system = "x86_64-linux"; builder = "/bin/sh"; };
in
{
  substring = {
    expr = builtins.hasContext (builtins.substring 0 5 "${drv}");
    expected = __;
  };

  concatenation = {
    expr = builtins.hasContext ("run " + "${drv}");
    expected = __;
  };

  replace = {
    expr = builtins.hasContext (builtins.replaceStrings [ "nix" ] [ "xin" ] "${drv}");
    expected = __;
  };

  number = {
    expr = builtins.hasContext (toString 1);
    expected = __;
  };
}
