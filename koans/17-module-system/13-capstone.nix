# Capstone: the module system
#
# This capstone combines options, `mkIf`, merged lists and the `config`
# argument. Real NixOS service modules follow this pattern: an `enable`
# option, more options, and a `config` that applies when `enable` is true.
#
# Replace __ with the `config` part of the service module. When the service is
# enabled, it must add its port to `firewall.allowedPorts`.
{ __, lib }:

let
  serviceModule =
    { config, ... }:
    {
      options = {
        services.greeter = {
          enable = lib.mkEnableOption "the greeter service";
          port = lib.mkOption { type = lib.types.port; default = 8000; };
        };
        firewall.allowedPorts = lib.mkOption {
          type = lib.types.listOf lib.types.port;
          default = [ ];
        };
      };
      config = __;
    };
  eval = modules: (lib.evalModules { modules = [ serviceModule ] ++ modules; }).config;
in
{
  off = {
    expr = (eval [ ]).firewall.allowedPorts;
    expected = [ ];
  };

  on = {
    expr = (eval [ { services.greeter.enable = true; } ]).firewall.allowedPorts;
    expected = [ 8000 ];
  };

  otherPort = {
    expr = (eval [ { services.greeter = { enable = true; port = 9000; }; } ]).firewall.allowedPorts;
    expected = [ 9000 ];
  };

  withOtherRules = {
    expr =
      let
        config = eval [
          { services.greeter.enable = true; }
          { firewall.allowedPorts = [ 22 ]; }
        ];
      in
      builtins.sort (a: b: a < b) config.firewall.allowedPorts;
    expected = [ 22 8000 ];
  };
}
