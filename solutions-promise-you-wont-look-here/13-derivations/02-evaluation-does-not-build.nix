# Evaluation does not build
#
# Nix works in two phases. "Evaluation" computes the derivation and its store
# paths: `outPath` for the result and `drvPath` for the recipe. "Realisation"
# runs the builder later. The koans only evaluate, so the absent builder below
# causes no error.
{ __ }:

let
  drv = derivation {
    name = "hello";
    system = "x86_64-linux";
    builder = "/does/not/exist";
  };
  storeName = path: builtins.head (builtins.match "/nix/store/[a-z0-9]{32}-(.*)" path);
in
{
  outPath = {
    expr = storeName drv.outPath;
    expected = /*>*/ "hello" /*<*/;
  };

  drvPath = {
    expr = storeName drv.drvPath;
    expected = /*>*/ "hello.drv" /*<*/;
  };
}
