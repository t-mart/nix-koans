# finalAttrs
#
# With `mkDerivation (finalAttrs: { ... })`, attributes refer to the final
# attributes, after all overrides. With `rec`, they keep the old values. New
# packages in nixpkgs use the `finalAttrs` pattern for this reason. This
# `mkPackage` supports both forms.
{ __ }:

let
  fix = f: let x = f x; in x;
  mkPackage =
    fn:
    let
      attrs = fix fn;
    in
    derivation ({ system = "x86_64-linux"; builder = "/bin/sh"; } // attrs // { name = "${attrs.pname}-${attrs.version}"; })
    // {
      overrideAttrs = f: mkPackage (final: let prev = fn final; in prev // f prev);
    };
  withFinalAttrs = mkPackage (finalAttrs: {
    pname = "hello";
    version = "2.12";
    src = "hello-${finalAttrs.version}.tar.gz";
  });
  withRec = mkPackage (finalAttrs: rec {
    pname = "hello";
    version = "2.12";
    src = "hello-${version}.tar.gz";
  });
in
{
  original = {
    expr = withFinalAttrs.src;
    expected = /*>*/ "hello-2.12.tar.gz" /*<*/;
  };

  finalAttrsOverride = {
    expr = (withFinalAttrs.overrideAttrs (old: { version = "2.13"; })).src;
    expected = /*>*/ "hello-2.13.tar.gz" /*<*/;
  };

  recOverride = {
    expr = (withRec.overrideAttrs (old: { version = "2.13"; })).src;
    expected = /*>*/ "hello-2.12.tar.gz" /*<*/;
  };
}
