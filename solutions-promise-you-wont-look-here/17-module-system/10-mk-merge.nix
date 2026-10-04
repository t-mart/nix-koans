# mkMerge
#
# `lib.mkMerge` combines a list of definitions inside one module. With
# `mkIf`, it lets one module hold several conditional parts, as in many NixOS
# service modules.
{ __, lib }:

let
  eval =
    value:
    (lib.evalModules {
      modules = [
        {
          options = {
            enable = lib.mkOption { type = lib.types.bool; default = false; };
            packages = lib.mkOption { type = lib.types.listOf lib.types.str; default = [ ]; };
            port = lib.mkOption { type = lib.types.int; default = 0; };
          };
        }
        (
          { config, ... }:
          {
            config = lib.mkMerge [
              { packages = [ "git" ]; }
              (lib.mkIf config.enable {
                packages = [ "nginx" ];
                port = 80;
              })
            ];
          }
        )
        { enable = value; }
      ];
    }).config;
in
{
  enabled = {
    expr = builtins.sort (a: b: a < b) (eval true).packages;
    expected = /*>*/ [ "git" "nginx" ] /*<*/;
  };

  enabledPort = {
    expr = (eval true).port;
    expected = /*>*/ 80 /*<*/;
  };

  disabled = {
    expr = (eval false).packages;
    expected = /*>*/ [ "git" ] /*<*/;
  };
}
