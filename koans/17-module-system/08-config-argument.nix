# The config argument
#
# A module function gets `config`, the final merged configuration of all
# modules. So a module can read options that other modules set, in any order.
# This is the fixed point from the overlay koans again.
{ __, lib }:

let
  result = lib.evalModules {
    modules = [
      {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          greeting = lib.mkOption { type = lib.types.str; };
          port = lib.mkOption { type = lib.types.int; };
          url = lib.mkOption { type = lib.types.str; };
        };
      }
      ({ config, ... }: { greeting = "Hello, ${config.name}!"; })
      ({ config, ... }: { url = "http://localhost:${toString config.port}"; })
      { name = "Nix"; port = 8080; }
    ];
  };
in
{
  greeting = {
    expr = result.config.greeting;
    expected = __;
  };

  url = {
    expr = result.config.url;
    expected = __;
  };
}
