# Capstone: fixed points and overlays
#
# This capstone combines derivations, `fix`, overlays and their order. It is a
# small model of nixpkgs: an overlay updates a library, and each package that
# uses the library gets a new store path.
#
# Replace the first __ with the package set: apply `security` and then
# `extra` to `base`, and take the fixed point. Then predict the other values.
{ __ }:

let
  fix = f: let x = f x; in x;
  extends = overlay: f: final: let prev = f final; in prev // overlay final prev;
  mkPackage =
    args@{ pname, version, ... }:
    derivation (
      args
      // {
        name = "${pname}-${version}";
        system = "x86_64-linux";
        builder = "/bin/sh";
      }
    );
  base = final: {
    zlib = mkPackage { pname = "zlib"; version = "1.3"; };
    curl = mkPackage { pname = "curl"; version = "8.9"; args = [ "-c" "link ${final.zlib}" ]; };
  };
  security = final: prev: { zlib = mkPackage { pname = "zlib"; version = "1.3.1"; }; };
  extra = final: prev: {
    wget = mkPackage { pname = "wget"; version = "1.24"; args = [ "-c" "link ${final.zlib}" ]; };
  };
  pkgs = __;
  original = fix base;
in
{
  names = {
    expr = builtins.attrNames pkgs;
    expected = [ "curl" "wget" "zlib" ];
  };

  zlib = {
    expr = pkgs.zlib.name;
    expected = __;
  };

  curlSeesZlib = {
    expr = builtins.match ".*zlib-(.*)" (builtins.elemAt pkgs.curl.args 1);
    expected = __;
  };

  curlRebuilt = {
    expr = pkgs.curl.outPath == original.curl.outPath;
    expected = __;
  };
}
