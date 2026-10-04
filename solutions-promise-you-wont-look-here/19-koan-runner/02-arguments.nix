# Arguments
#
# The runner calls each koan file in the same way as `callPackage`. It reads
# the arguments of the file with `builtins.functionArgs` and passes only
# those. So a koan that needs `lib` or `pkgs` names it in its first line.
{ __ }:

let
  lib = "the nixpkgs library";
  pkgs = "the nixpkgs package set";
  # From default.nix:
  call =
    file:
    let
      f = import file;
    in
    f (builtins.intersectAttrs (builtins.functionArgs f) { inherit __ lib pkgs; });
in
{
  basics = {
    expr = builtins.functionArgs (import ../01-basics/01-booleans.nix);
    expected = /*>*/ { __ = false; } /*<*/;
  };

  libraryKoan = {
    expr = builtins.attrNames (builtins.functionArgs (import ../12-nixpkgs-library/01-lib-is-nix-code.nix));
    expected = /*>*/ [ "__" "lib" ] /*<*/;
  };

  passed = {
    expr = builtins.attrNames (
      builtins.intersectAttrs (builtins.functionArgs (import ../16-nixpkgs-in-practice/01-import-nixpkgs.nix)) {
        __ = 1;
        lib = 2;
        pkgs = 3;
      }
    );
    expected = /*>*/ [ "__" "pkgs" ] /*<*/;
  };

  called = {
    expr = builtins.attrNames (call ../01-basics/01-booleans.nix);
    expected = /*>*/ [ "falsehood" "truth" ] /*<*/;
  };
}
