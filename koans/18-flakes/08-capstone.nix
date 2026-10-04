# Capstone: flakes
#
# This capstone combines flake outputs, `self`, per-system sets, overlays and
# the import of nixpkgs. The checks call your `outputs` with a mock nixpkgs
# input.
#
# Replace __ with an `outputs` function. Its result must have:
#
# - `overlays.default`, which adds
#   `tool = { name = "tool"; system = prev.hello.system; }`.
# - `packages.<system>.default`, the `tool` from nixpkgs with that overlay,
#   for each system in `systems`.
# - `devShells.<system>.default`, the set
#   `{ name = "tool-shell"; packages = [ tool hello ]; }`.
{ __, lib }:

let
  systems = [ "x86_64-linux" "aarch64-linux" ];
  nixpkgs = { outPath = ./fixtures/mock-nixpkgs; };
  flake = {
    description = "A tool";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs";
    outputs = __;
  };
  result = lib.fix (self: flake.outputs { inherit self nixpkgs; });
in
{
  systems = {
    expr = builtins.attrNames result.packages;
    expected = [ "aarch64-linux" "x86_64-linux" ];
  };

  package = {
    expr = result.packages.aarch64-linux.default;
    expected = { name = "tool"; system = "aarch64-linux"; };
  };

  shellPackages = {
    expr = map (p: p.name) result.devShells.x86_64-linux.default.packages;
    expected = [ "tool" "hello" ];
  };

  shellName = {
    expr = result.devShells.x86_64-linux.default.name;
    expected = "tool-shell";
  };

  overlay = {
    expr =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ result.overlays.default ];
        };
      in
      pkgs.tool.name;
    expected = "tool";
  };
}
