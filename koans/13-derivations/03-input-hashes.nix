# Input hashes
#
# The store path of a derivation contains a hash of all of its inputs. Extra
# attributes are inputs too: the builder gets them as environment variables.
# A change to any input gives a new store path. So Nix can install two versions
# of a package side by side.
{ __ }:

let
  mk = attrs: derivation ({ name = "demo"; system = "x86_64-linux"; builder = "/bin/sh"; } // attrs);
in
{
  same = {
    expr = (mk { }).outPath == (mk { }).outPath;
    expected = __;
  };

  newArgs = {
    expr = (mk { args = [ "-c" "true" ]; }).outPath == (mk { }).outPath;
    expected = __;
  };

  newVariable = {
    expr = (mk { greeting = "hi"; }).outPath == (mk { }).outPath;
    expected = __;
  };

  newName = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" (mk { name = "other"; }).outPath;
    expected = __;
  };
}
