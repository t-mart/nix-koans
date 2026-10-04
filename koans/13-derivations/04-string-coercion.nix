# String coercion
#
# A set with an `outPath` attribute converts to that string. So
# `"${pkgs.hello}/bin/hello"` gives the path of a program inside a package.
# NixOS modules use this form all the time, for example in service commands.
{ __ }:

let
  drv = derivation { name = "hello"; system = "x86_64-linux"; builder = "/bin/sh"; };
in
{
  anySet = {
    expr = "${{ outPath = "/some/path"; }}";
    expected = __;
  };

  derivation = {
    expr = "${drv}" == drv.outPath;
    expected = __;
  };

  toString = {
    expr = toString drv == drv.outPath;
    expected = __;
  };

  program = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" "${drv}/bin/hello";
    expected = __;
  };
}
