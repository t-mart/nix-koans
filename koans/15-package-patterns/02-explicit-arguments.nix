# Explicit arguments
#
# The second argument of `callPackage` overrides the package set. nixpkgs uses
# it to choose a variant of a dependency, as in
# `callPackage ./foo.nix { python3 = python311; }`.
{ __ }:

let
  pkgs = {
    git = "git-2.45";
    vim = "vim-9.1";
  };
  callPackage = f: args: f (builtins.intersectAttrs (builtins.functionArgs f) pkgs // args);
in
{
  replace = {
    expr = callPackage ({ git }: git) { git = "my-git"; };
    expected = __;
  };

  mixed = {
    expr = callPackage ({ git, vim }: "${git} ${vim}") { vim = "neovim"; };
    expected = __;
  };
}
