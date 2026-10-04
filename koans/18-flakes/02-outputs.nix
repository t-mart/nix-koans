# outputs
#
# `outputs` is a function. Nix fetches each input and passes them all to
# `outputs` in one set, plus `self` for the flake itself. Add `...` to the
# pattern to ignore inputs that the function does not name. Here, a small
# mock stands in for nixpkgs.
{ __, lib }:

let
  systems = [ "x86_64-linux" "aarch64-linux" ];
  nixpkgs = {
    outPath = ./fixtures/mock-nixpkgs;
    legacyPackages = lib.genAttrs systems (system: import ./fixtures/mock-nixpkgs { inherit system; });
  };
  flake = {
    outputs =
      { self, nixpkgs, ... }:
      {
        systems = builtins.attrNames nixpkgs.legacyPackages;
        hello = nixpkgs.legacyPackages.x86_64-linux.hello.name;
      };
  };
  result = flake.outputs { self = result; inherit nixpkgs; };
in
{
  arguments = {
    expr = builtins.functionArgs flake.outputs;
    expected = __;
  };

  systems = {
    expr = result.systems;
    expected = __;
  };

  hello = {
    expr = result.hello;
    expected = __;
  };

  extraInput = {
    expr = flake.outputs { self = null; inherit nixpkgs; flake-utils = { }; } ? systems;
    expected = __;
  };
}
