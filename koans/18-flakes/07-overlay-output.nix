# Overlay output
#
# A flake often defines its packages in an overlay, and applies that overlay
# to its own nixpkgs input. Other flakes and NixOS configurations can then use
# the same overlay. `import nixpkgs { ... }` works on a flake input, because
# an input converts to its store path. Read the mock in `fixtures` too.
#
# Replace __ with an import of the `nixpkgs` input for `system`, with the
# overlay of this flake.
{ __, lib }:

let
  systems = [ "x86_64-linux" "aarch64-linux" ];
  nixpkgs = { outPath = ./fixtures/mock-nixpkgs; };
  outputs =
    { self, nixpkgs }:
    {
      overlays.default = final: prev: {
        greeter = {
          name = "greeter";
          uses = prev.hello.name;
          system = prev.hello.system;
        };
      };
      packages = lib.genAttrs systems (
        system:
        let
          pkgs = __;
        in
        { default = pkgs.greeter; }
      );
    };
  result = lib.fix (self: outputs { inherit self nixpkgs; });
in
{
  x86 = {
    expr = result.packages.x86_64-linux.default;
    expected = { name = "greeter"; system = "x86_64-linux"; uses = "hello"; };
  };

  arm = {
    expr = result.packages.aarch64-linux.default.system;
    expected = "aarch64-linux";
  };
}
