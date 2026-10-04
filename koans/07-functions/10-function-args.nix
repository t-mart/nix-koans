# functionArgs
#
# `builtins.functionArgs` looks inside the set pattern of a function. It
# gives a set from each name to `true` when the name has a default. nixpkgs
# uses it to find the arguments that a package needs, as a later koan shows.
{ __ }:

{
  pattern = {
    expr = builtins.functionArgs ({ a, b ? 1 }: a);
    expected = __;
  };

  plainArgument = {
    expr = builtins.functionArgs (x: x);
    expected = __;
  };

  names = {
    expr = builtins.attrNames (builtins.functionArgs ({ pkgs, lib, ... }: null));
    expected = __;
  };
}
