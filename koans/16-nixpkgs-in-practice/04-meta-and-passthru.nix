# meta and passthru
#
# `meta` describes a package: its license, platforms, main program and
# maintainers. `passthru` adds attributes to the package without a change to
# the build. Neither changes the store path. Tools such as `nix search` read
# `meta`.
{ __, pkgs }:

let
  mk =
    attrs:
    pkgs.stdenv.mkDerivation (
      {
        pname = "demo";
        version = "1.0";
        dontUnpack = true;
        installPhase = "touch $out";
      }
      // attrs
    );
  plain = mk { };
in
{
  license = {
    expr = pkgs.hello.meta.license.spdxId;
    expected = __;
  };

  mainProgram = {
    expr = pkgs.hello.meta.mainProgram;
    expected = __;
  };

  passthruValue = {
    expr = (mk { passthru.greeting = "hi"; }).greeting;
    expected = __;
  };

  passthruSamePath = {
    expr = (mk { passthru.greeting = "hi"; }).outPath == plain.outPath;
    expected = __;
  };

  metaSamePath = {
    expr = (mk { meta.description = "A demo"; }).outPath == plain.outPath;
    expected = __;
  };

  attributeNewPath = {
    expr = (mk { greeting = "hi"; }).outPath == plain.outPath;
    expected = __;
  };
}
