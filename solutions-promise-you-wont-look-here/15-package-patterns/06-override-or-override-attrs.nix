# override or overrideAttrs
#
# Use `override` to change the arguments of the package function, such as
# dependencies and feature flags. Use `overrideAttrs` to change the
# attributes of the derivation, such as `version`, `src` and `patches`.
#
# Replace each __ with a call of `curl.override` or `curl.overrideAttrs`.
{ __ }:

let
  makeOverridable = f: args: f args // { override = newArgs: makeOverridable f (args // newArgs); };
  mkPackage =
    attrs:
    derivation ({ system = "x86_64-linux"; builder = "/bin/sh"; } // attrs // { name = "${attrs.pname}-${attrs.version}"; })
    // {
      overrideAttrs = f: mkPackage (attrs // f attrs);
    };
  zlib = mkPackage { pname = "zlib"; version = "1.3"; };
  zlibNew = mkPackage { pname = "zlib"; version = "1.3.1"; };
  curlFunction =
    { zlib, withHttp3 ? false }:
    mkPackage {
      pname = "curl";
      version = "8.9";
      http3 = withHttp3;
      zlibName = zlib.name;
    };
  curl = makeOverridable curlFunction { inherit zlib; };
in
{
  newerVersion = {
    expr = (/*>*/ curl.overrideAttrs (old: { version = "8.10"; }) /*<*/).name;
    expected = "curl-8.10";
  };

  withHttp3 = {
    expr = (/*>*/ curl.override { withHttp3 = true; } /*<*/).http3;
    expected = true;
  };

  newZlib = {
    expr = (/*>*/ curl.override { zlib = zlibNew; } /*<*/).zlibName;
    expected = "zlib-1.3.1";
  };
}
