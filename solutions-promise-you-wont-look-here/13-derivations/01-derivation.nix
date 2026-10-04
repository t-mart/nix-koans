# derivation
#
# A "derivation" is a build recipe. The built-in `derivation` function takes
# a name, a system, a builder program and its arguments. It gives a set that
# describes the build. In the end, every package in nixpkgs is a derivation.
{ __ }:

let
  drv = derivation {
    name = "hello";
    system = "x86_64-linux";
    builder = "/bin/sh";
    args = [ "-c" "echo hello > $out" ];
  };
in
{
  type = {
    expr = drv.type;
    expected = /*>*/ "derivation" /*<*/;
  };

  typeOf = {
    expr = builtins.typeOf drv;
    expected = /*>*/ "set" /*<*/;
  };

  name = {
    expr = drv.name;
    expected = /*>*/ "hello" /*<*/;
  };

  hasOutPath = {
    expr = drv ? outPath;
    expected = /*>*/ true /*<*/;
  };
}
