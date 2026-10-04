# Types
#
# Each option has a "type", such as `types.str`, `types.port` or
# `types.listOf types.str`. The module system checks each definition against
# the type. A bad value is an error that names the module that set it.
{ __, lib }:

let
  eval =
    value:
    (lib.evalModules {
      modules = [
        { options.port = lib.mkOption { type = lib.types.port; }; }
        { port = value; }
      ];
    }).config.port;
in
{
  valid = {
    expr = builtins.tryEval (eval 8080);
    expected = /*>*/ { success = true; value = 8080; } /*<*/;
  };

  string = {
    expr = (builtins.tryEval (eval "8080")).success;
    expected = /*>*/ false /*<*/;
  };

  tooLarge = {
    expr = (builtins.tryEval (eval 70000)).success;
    expected = /*>*/ false /*<*/;
  };

  check = {
    expr = lib.types.str.check 1;
    expected = /*>*/ false /*<*/;
  };
}
