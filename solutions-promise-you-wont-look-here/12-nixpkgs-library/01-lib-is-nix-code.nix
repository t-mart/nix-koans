# lib is Nix code
#
# `lib` is the standard library of nixpkgs. It is ordinary Nix code in the
# `lib` directory of the nixpkgs repository, not part of the language. It also
# provides many of the builtins. The runner gives `lib` to each koan that names
# it in its first line.
{ __, lib }:

{
  libType = {
    expr = builtins.typeOf lib;
    expected = /*>*/ "set" /*<*/;
  };

  reexport = {
    expr = lib ? attrNames;
    expected = /*>*/ true /*<*/;
  };

  onlyInLib = {
    expr = builtins ? recursiveUpdate;
    expected = /*>*/ false /*<*/;
  };

  identity = {
    expr = lib.id 5;
    expected = /*>*/ 5 /*<*/;
  };
}
