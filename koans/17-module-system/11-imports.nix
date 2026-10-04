# imports
#
# `imports` adds other modules, often from files. A NixOS configuration
# imports `hardware-configuration.nix` in this way. The module system imports
# each file only once, even when several modules import it. Read the files in
# `fixtures` for this koan.
{ __, lib }:

let
  result = lib.evalModules {
    modules = [
      { imports = [ ./fixtures/greeting.nix ./fixtures/options.nix ]; }
      { name = "Nix"; }
    ];
  };
in
{
  greeting = {
    expr = result.config.greeting;
    expected = __;
  };

  options = {
    expr = builtins.attrNames result.config;
    expected = __;
  };
}
