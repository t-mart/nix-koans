# Multiple outputs
#
# A derivation can have several "outputs", such as `out` for programs and
# `dev` for headers. Each output has its own store path. A system can install
# only the outputs that it needs, which keeps it small.
{ __ }:

let
  drv = derivation {
    name = "lib";
    system = "x86_64-linux";
    builder = "/bin/sh";
    outputs = [ "out" "dev" ];
  };
  storeName = path: builtins.head (builtins.match "/nix/store/[a-z0-9]{32}-(.*)" path);
in
{
  outputs = {
    expr = drv.outputs;
    expected = __;
  };

  separatePaths = {
    expr = drv.dev.outPath == drv.out.outPath;
    expected = __;
  };

  defaultOutput = {
    expr = storeName drv.outPath;
    expected = __;
  };

  devOutput = {
    expr = storeName drv.dev.outPath;
    expected = __;
  };
}
