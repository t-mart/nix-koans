# Other outputs
#
# Flakes have standard output names. `devShells` and `checks` have the same
# shape as `packages`. `apps` hold programs for `nix run`. `overlays` and
# `nixosModules` hold overlays and modules, without a system level.
{ __, lib }:

let
  outputs =
    { self }:
    {
      packages.x86_64-linux.default = { name = "tool"; };
      devShells.x86_64-linux.default = {
        name = "tool-shell";
        packages = [ self.packages.x86_64-linux.default ];
      };
      checks.x86_64-linux.build = self.packages.x86_64-linux.default;
      apps.x86_64-linux.default = {
        type = "app";
        program = "/nix/store/example-tool/bin/tool";
      };
      overlays.default = final: prev: { tool = self.packages.x86_64-linux.default; };
      nixosModules.default = { config, ... }: { };
    };
  result = lib.fix (self: outputs { inherit self; });
in
{
  names = {
    expr = builtins.attrNames result;
    expected = /*>*/ [ "apps" "checks" "devShells" "nixosModules" "overlays" "packages" ] /*<*/;
  };

  check = {
    expr = result.checks.x86_64-linux.build.name;
    expected = /*>*/ "tool" /*<*/;
  };

  app = {
    expr = result.apps.x86_64-linux.default.type;
    expected = /*>*/ "app" /*<*/;
  };

  overlay = {
    expr = (result.overlays.default { } { }).tool.name;
    expected = /*>*/ "tool" /*<*/;
  };

  noSystem = {
    expr = result.overlays ? x86_64-linux;
    expected = /*>*/ false /*<*/;
  };
}
