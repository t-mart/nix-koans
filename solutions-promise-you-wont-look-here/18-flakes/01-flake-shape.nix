# Flake shape
#
# A "flake" is a directory with a `flake.nix` file. The file holds a set with
# a `description`, the `inputs` that the flake depends on, and an `outputs`
# function. Nix records the exact inputs in `flake.lock`. These koans treat
# `flake.nix` as plain Nix, which it is.
{ __ }:

let
  flake = {
    description = "A greeting tool";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs";
    outputs = { self, nixpkgs }: { greeting = "hello"; };
  };
in
{
  names = {
    expr = builtins.attrNames flake;
    expected = /*>*/ [ "description" "inputs" "outputs" ] /*<*/;
  };

  inputs = {
    expr = flake.inputs;
    expected = /*>*/ { nixpkgs = { url = "github:NixOS/nixpkgs"; }; } /*<*/;
  };

  outputs = {
    expr = builtins.typeOf flake.outputs;
    expected = /*>*/ "lambda" /*<*/;
  };
}
