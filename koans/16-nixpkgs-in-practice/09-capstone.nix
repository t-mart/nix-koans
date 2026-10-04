# Capstone: nixpkgs in practice
#
# This capstone combines overlays, `callPackage`, trivial builders and
# `lib.getExe`. Most custom package sets, in a flake or a NixOS configuration,
# look like this.
#
# Replace __ with a package `greeter`. Use `final.callPackage` with a function
# that takes `writeShellScriptBin` and `hello`. The function must give a
# script named "greeter" that runs `hello` with the argument `--greeting=hi`.
{ __, pkgs }:

let
  overlay = final: prev: {
    greeter = __;
  };
  myPkgs = import <nixpkgs> {
    system = pkgs.stdenv.hostPlatform.system;
    overlays = [ overlay ];
  };
in
{
  name = {
    expr = myPkgs.greeter.name;
    expected = "greeter";
  };

  program = {
    expr = builtins.match ".*/bin/(.*)" (myPkgs.lib.getExe myPkgs.greeter);
    expected = [ "greeter" ];
  };

  command = {
    expr = myPkgs.lib.hasInfix "/bin/hello --greeting=hi" myPkgs.greeter.text;
    expected = true;
  };

  dependsOnHello = {
    expr =
      let
        helloDrv = builtins.unsafeDiscardStringContext myPkgs.hello.drvPath;
      in
      builtins.getContext myPkgs.greeter.text ? ${helloDrv};
    expected = true;
  };

  overridable = {
    expr = myPkgs.greeter ? override;
    expected = true;
  };
}
