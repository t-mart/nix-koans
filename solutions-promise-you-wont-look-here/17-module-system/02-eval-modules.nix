# evalModules
#
# `lib.evalModules` merges a list of modules into one configuration. NixOS
# calls it with all of its modules plus your configuration. The result has
# `config` with the merged values. A module without `options` and `config`
# keys is all `config`.
{ __, lib }:

let
  result = lib.evalModules {
    modules = [
      { options.greeting = lib.mkOption { type = lib.types.str; }; }
      { config.greeting = "hello"; }
    ];
  };
  shorthand = lib.evalModules {
    modules = [
      { options.greeting = lib.mkOption { type = lib.types.str; }; }
      { greeting = "hi"; }
    ];
  };
in
{
  greeting = {
    expr = result.config.greeting;
    expected = /*>*/ "hello" /*<*/;
  };

  names = {
    expr = builtins.attrNames result.config;
    expected = /*>*/ [ "greeting" ] /*<*/;
  };

  shorthand = {
    expr = shorthand.config.greeting;
    expected = /*>*/ "hi" /*<*/;
  };
}
