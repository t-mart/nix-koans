# overrideAttrs
#
# `overrideAttrs` changes the attributes of the derivation, such as
# `version`, `src` or `patches`. Its argument is a function from the old
# attributes to the changes. Users call it to patch or update a package
# without a fork of nixpkgs.
#
# Replace the first __ with the `overrideAttrs` function of `mkPackage`. It
# takes a function `f`, and calls `mkPackage` again with `attrs` updated by
# `f attrs`. Then predict the last value.
{ __ }:

let
  mkPackage =
    attrs:
    derivation (
      attrs
      // {
        name = "${attrs.pname}-${attrs.version}";
        system = "x86_64-linux";
        builder = "/bin/sh";
      }
    )
    // {
      overrideAttrs = __;
    };
  hello = mkPackage { pname = "hello"; version = "2.12"; };
in
{
  newVersion = {
    expr = (hello.overrideAttrs (old: { version = "2.13"; })).name;
    expected = "hello-2.13";
  };

  fromOld = {
    expr = (hello.overrideAttrs (old: { pname = old.pname + "-patched"; })).name;
    expected = "hello-patched-2.12";
  };

  twice = {
    expr = ((hello.overrideAttrs (old: { version = "3"; })).overrideAttrs (old: { pname = "hi"; })).name;
    expected = "hi-3";
  };

  newStorePath = {
    expr = (hello.overrideAttrs (old: { version = "2.13"; })).outPath == hello.outPath;
    expected = __;
  };
}
