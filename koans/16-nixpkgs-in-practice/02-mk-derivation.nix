# mkDerivation
#
# `stdenv.mkDerivation` is the standard way to package software in nixpkgs.
# It calls `derivation` with a builder that runs "phases": unpack, configure,
# build, install and more. Compare it with your `mkPackage`.
{ __, pkgs }:

let
  drv = pkgs.stdenv.mkDerivation {
    pname = "demo";
    version = "1.0";
    dontUnpack = true;
    installPhase = "touch $out";
  };
in
{
  name = {
    expr = drv.name;
    expected = __;
  };

  type = {
    expr = drv.type;
    expected = __;
  };

  storeName = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" drv.outPath;
    expected = __;
  };

  overridable = {
    expr = drv ? overrideAttrs;
    expected = __;
  };
}
