# callPackage
#
# Almost every package in nixpkgs is a file with a function of the form
# `{ stdenv, fetchurl, ... }:`. `callPackage` calls such a function with the
# arguments that it names, taken from the package set. Explicit arguments
# come second.
#
# Replace __ with a function `callPackage`. It takes a function `f` and a set
# of explicit arguments. Use `builtins.functionArgs` and
# `builtins.intersectAttrs` to pick the arguments of `f` from `pkgs`.
{ __ }:

let
  pkgs = {
    git = "git-2.45";
    vim = "vim-9.1";
    curl = "curl-8.9";
  };
  callPackage = __;
in
{
  two = {
    expr = callPackage ({ git, curl }: "${git} and ${curl}") { };
    expected = "git-2.45 and curl-8.9";
  };

  one = {
    expr = callPackage ({ vim }: vim) { };
    expected = "vim-9.1";
  };
}
