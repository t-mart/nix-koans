# List order
#
# The order of a merged list depends on how the module system walks the
# modules, which is hard to predict. `lib.mkBefore` and `lib.mkAfter` put a
# definition at the front or at the back. Order matters for options such as
# shell init scripts and firewall rules.
{ __, lib }:

let
  eval =
    modules:
    (lib.evalModules {
      modules = [
        {
          options.lines = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
          };
        }
      ]
      ++ modules;
    }).config.lines;
in
{
  beforeAndAfter = {
    expr = eval [
      { lines = [ "middle" ]; }
      { lines = lib.mkAfter [ "last" ]; }
      { lines = lib.mkBefore [ "first" ]; }
    ];
    expected = /*>*/ [ "first" "middle" "last" ] /*<*/;
  };

  modulesOnly = {
    expr = builtins.length (eval [ { lines = [ "a" ]; } { lines = [ "b" ]; } ]);
    expected = /*>*/ 2 /*<*/;
  };
}
