# Submodules
#
# A "submodule" type gives an option a nested structure with its own options
# and defaults. `types.attrsOf (types.submodule ...)` is common in NixOS, as
# in `users.users.<name>` and `services.nginx.virtualHosts.<name>`.
{ __, lib }:

let
  inherit (lib) mkOption types;
  result = lib.evalModules {
    modules = [
      {
        options.users = mkOption {
          type = types.attrsOf (
            types.submodule {
              options = {
                uid = mkOption { type = types.int; };
                shell = mkOption { type = types.str; default = "bash"; };
              };
            }
          );
          default = { };
        };
      }
      { users.alice.uid = 1000; }
      { users.bob = { uid = 1001; shell = "zsh"; }; }
      { users.alice.shell = "fish"; }
    ];
  };
in
{
  names = {
    expr = builtins.attrNames result.config.users;
    expected = /*>*/ [ "alice" "bob" ] /*<*/;
  };

  merged = {
    expr = result.config.users.alice;
    expected = /*>*/ { shell = "fish"; uid = 1000; } /*<*/;
  };

  bob = {
    expr = result.config.users.bob.shell;
    expected = /*>*/ "zsh" /*<*/;
  };
}
