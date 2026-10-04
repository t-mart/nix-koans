# Defaults
#
# An argument with a default keeps its default when the package set lacks it.
# Package functions use defaults for feature flags, as in
# `{ withGui ? false }:`. An argument that the package set has always comes
# from the set, even with a default.
{ __ }:

let
  pkgs = {
    git = "git-2.45";
    vim = "vim-9.1";
  };
  callPackage = f: args: f (builtins.intersectAttrs (builtins.functionArgs f) pkgs // args);
  tool = { git, withGui ? false }: if withGui then "${git} with GUI" else git;
in
{
  default = {
    expr = callPackage tool { };
    expected = __;
  };

  explicit = {
    expr = callPackage tool { withGui = true; };
    expected = __;
  };

  setWins = {
    expr = callPackage ({ vim ? "none" }: vim) { };
    expected = __;
  };
}
