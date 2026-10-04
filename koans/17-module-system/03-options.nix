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
    expected = __;
  };

  default = {
    expr = result.config.name;
    expected = __;
  };

  declaration = {
    expr = result.options.port.default;
    expected = __;
  };

  description = {
    expr = result.options.port.description;
    expected = __;
  };
}
