# Build inputs
#
# `nativeBuildInputs` hold tools that run during the build, such as compilers
# and `pkg-config`. `buildInputs` hold libraries for the result. The difference
# matters in "cross-compilation", where the build machine and the target
# differ. Here, `pkgsCross.riscv64` builds for RISC-V on your machine.
{ __, pkgs }:

let
  systemOf = p: p.stdenv.hostPlatform.system;
  drv = pkgs.pkgsCross.riscv64.callPackage (
    { stdenv, pkg-config, zlib }:
    stdenv.mkDerivation {
      pname = "demo";
      version = "1.0";
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ zlib ];
    }
  ) { };
in
{
  target = {
    expr = systemOf drv;
    expected = __;
  };

  toolRunsHere = {
    expr = map systemOf drv.nativeBuildInputs == [ (systemOf pkgs.hello) ];
    expected = __;
  };

  libraryForTarget = {
    expr = map systemOf drv.buildInputs;
    expected = __;
  };
}
