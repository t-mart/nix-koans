# Options
#
# `lib.mkOption` declares an "option" with a type, a default value and a
# description. NixOS has thousands of options; `man configuration.nix` lists
# them. A module that sets a value gives a "definition".
{ __, lib }:

let
  result = lib.evalModules {
    modules = [
      {
        options = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 80;
            description = "The port to listen on.";
          };
          name = lib.mkOption {
            type = lib.types.str;
            default = "web";
          };
        };
      }
      { port = 8080; }
    ];
  };
in
{
  defined = {
    expr = result.config.port;
    expected = /*>*/ 8080 /*<*/;
  };

  default = {
    expr = result.config.name;
    expected = /*>*/ "web" /*<*/;
  };

  declaration = {
    expr = result.options.port.default;
    expected = /*>*/ 80 /*<*/;
  };

  description = {
    expr = result.options.port.description;
    expected = /*>*/ "The port to listen on." /*<*/;
  };
}
