# Priorities
#
# Each definition has a "priority". A plain definition wins over
# `lib.mkDefault`, and `lib.mkForce` wins over both. NixOS modules set their
# values with `mkDefault`, so your configuration wins without `mkForce`. The
# default of the option itself has the lowest priority.
{ __, lib }:

let
  eval =
    modules:
    (lib.evalModules {
      modules = [
        {
          options.port = lib.mkOption {
            type = lib.types.int;
            default = 80;
          };
        }
      ]
      ++ modules;
    }).config.port;
in
{
  plainBeatsDefault = {
    expr = eval [ { port = lib.mkDefault 3000; } { port = 8080; } ];
    expected = /*>*/ 8080 /*<*/;
  };

  forceBeatsPlain = {
    expr = eval [ { port = lib.mkForce 22; } { port = 8080; } ];
    expected = /*>*/ 22 /*<*/;
  };

  mkDefaultBeatsOptionDefault = {
    expr = eval [ { port = lib.mkDefault 3000; } ];
    expected = /*>*/ 3000 /*<*/;
  };

  optionDefault = {
    expr = eval [ ];
    expected = /*>*/ 80 /*<*/;
  };
}
