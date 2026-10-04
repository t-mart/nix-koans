# Per-system outputs
#
# Flake outputs name each system explicitly, as in
# `packages.x86_64-linux.hello`. Flakes cannot read `builtins.currentSystem`,
# because evaluation must give the same result on each machine. A helper such
# as `forAllSystems` makes the set for a list of systems.
#
# Replace __ with a function `forAllSystems`. It takes a function of `system`
# and gives a set with one attribute for each system in `systems`.
{ __, lib }:

let
  systems = [ "x86_64-linux" "aarch64-linux" ];
  nixpkgs = {
    outPath = ./fixtures/mock-nixpkgs;
    legacyPackages = lib.genAttrs systems (system: import ./fixtures/mock-nixpkgs { inherit system; });
  };
  forAllSystems = __;
  outputs =
    { self, nixpkgs }:
    {
      packages = forAllSystems (system: { hello = nixpkgs.legacyPackages.${system}.hello; });
    };
  result = lib.fix (self: outputs { inherit self nixpkgs; });
in
{
  systems = {
    expr = builtins.attrNames result.packages;
    expected = [ "aarch64-linux" "x86_64-linux" ];
  };

  arm = {
    expr = result.packages.aarch64-linux.hello.system;
    expected = "aarch64-linux";
  };
}
