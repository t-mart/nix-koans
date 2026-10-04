# Merge rules
#
# When several modules define one option, its type decides how to merge the
# values. Lists concatenate and sets merge. Two different definitions of a
# single value, such as an integer, "conflict". Equal definitions do not.
# Do not rely on the list order across modules.
{ __, lib }:

let
  inherit (lib) mkOption types;
  eval =
    modules:
    (lib.evalModules {
      modules = [
        {
          options = {
            packages = mkOption { type = types.listOf types.str; default = [ ]; };
            env = mkOption { type = types.attrsOf types.str; default = { }; };
            port = mkOption { type = types.int; };
          };
        }
      ]
      ++ modules;
    }).config;
in
{
  lists = {
    expr = builtins.sort (a: b: a < b) (eval [ { packages = [ "git" ]; } { packages = [ "vim" ]; } ]).packages;
    expected = /*>*/ [ "git" "vim" ] /*<*/;
  };

  sets = {
    expr = (eval [ { env.EDITOR = "vim"; } { env.PAGER = "less"; } ]).env;
    expected = /*>*/ { EDITOR = "vim"; PAGER = "less"; } /*<*/;
  };

  conflict = {
    expr = (builtins.tryEval (eval [ { port = 1; } { port = 2; } ]).port).success;
    expected = /*>*/ false /*<*/;
  };

  equal = {
    expr = (eval [ { port = 1; } { port = 1; } ]).port;
    expected = /*>*/ 1 /*<*/;
  };
}
