# Lookup paths
#
# `<nixpkgs>` is a "lookup path". Nix searches for it in the list
# `builtins.nixPath`, which comes from the `NIX_PATH` environment variable.
# `<name>` is short for `builtins.findFile builtins.nixPath "name"`. The result
# depends on the machine, so flakes forbid lookup paths.
{ __ }:

let
  searchPath = [ { prefix = "fx"; path = ./fixtures; } ];
in
{
  nixPathType = {
    expr = builtins.typeOf builtins.nixPath;
    expected = /*>*/ "list" /*<*/;
  };

  findFile = {
    expr = baseNameOf (builtins.findFile searchPath "fx/greeting.txt");
    expected = /*>*/ "greeting.txt" /*<*/;
  };

  readFound = {
    expr = builtins.readFile (builtins.findFile searchPath "fx/greeting.txt");
    expected = /*>*/ "Hello from a file\n" /*<*/;
  };
}
