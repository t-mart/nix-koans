# Capstone: package patterns
#
# This capstone combines `fix`, overlays, `callPackage`, `override` and
# `overrideAttrs`. It is a small model of how you customize nixpkgs with an
# overlay.
#
# Replace __ with an overlay. It must turn on HTTP/3 in `curl` with
# `override`, and update `zlib` to version "1.3.1" with `overrideAttrs`.
{ __ }:

let
  fix = f: let x = f x; in x;
  extends = overlay: f: final: let prev = f final; in prev // overlay final prev;
  makeOverridable = f: args: f args // { override = newArgs: makeOverridable f (args // newArgs); };
  mkPackage =
    attrs:
    derivation ({ system = "x86_64-linux"; builder = "/bin/sh"; } // attrs // { name = "${attrs.pname}-${attrs.version}"; })
    // {
      overrideAttrs = f: mkPackage (attrs // f attrs);
    };
  base =
    final:
    let
      callPackage = f: args: makeOverridable f (builtins.intersectAttrs (builtins.functionArgs f) final // args);
    in
    {
      zlib = callPackage ({ }: mkPackage { pname = "zlib"; version = "1.3"; }) { };
      curl = callPackage (
        { zlib, withHttp3 ? false }:
        mkPackage {
          pname = "curl";
          version = "8.9";
          http3 = withHttp3;
          zlibName = zlib.name;
        }
      ) { };
    };
  overlay = /*>*/ final: prev: { curl = prev.curl.override { withHttp3 = true; }; zlib = prev.zlib.overrideAttrs (old: { version = "1.3.1"; }); } /*<*/;
  pkgs = fix (extends overlay base);
in
{
  http3 = {
    expr = pkgs.curl.http3;
    expected = true;
  };

  zlib = {
    expr = pkgs.zlib.name;
    expected = "zlib-1.3.1";
  };

  curlSeesZlib = {
    expr = pkgs.curl.zlibName;
    expected = "zlib-1.3.1";
  };
}
