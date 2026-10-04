# Real overrides
#
# `override` and `overrideAttrs` work on each nixpkgs package. A changed
# package gets a new store path, so the binary cache does not have it, and Nix
# builds it from source. An override without changes keeps the store path.
{ __, pkgs }:

{
  noChange = {
    expr = (pkgs.hello.overrideAttrs (old: { })).outPath == pkgs.hello.outPath;
    expected = /*>*/ true /*<*/;
  };

  noTests = {
    expr = (pkgs.hello.overrideAttrs (old: { doCheck = false; })).outPath == pkgs.hello.outPath;
    expected = /*>*/ false /*<*/;
  };

  otherCompiler = {
    expr = (pkgs.hello.override { stdenv = pkgs.clangStdenv; }).outPath == pkgs.hello.outPath;
    expected = /*>*/ false /*<*/;
  };

  twoArguments = {
    expr = (pkgs.hello.overrideAttrs (finalAttrs: prevAttrs: { pname = prevAttrs.pname + "-custom"; })).pname;
    expected = /*>*/ "hello-custom" /*<*/;
  };
}
