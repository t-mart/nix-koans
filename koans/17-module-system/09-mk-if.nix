# mkIf
#
# `lib.mkIf cond value` defines a value only when `cond` is true. Use it
# instead of an `if` around the whole module. The module system must know the
# names that each module defines before it computes `config`, as with
# overlays. `mkIf` keeps the names fixed and delays the condition.
#
# Replace the first __ with a definition of `packages`. It must give
# `[ "nginx" ]` only when `config.enable` is true. Then predict the result.
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
          };
        }
        ({ config, ... }: { packages = __; })
        { enable = value; }
      ];
    }).config.packages;
in
{
  enabled = {
    expr = eval true;
    expected = [ "nginx" ];
  };

  disabled = {
    expr = eval false;
    expected = __;
  };
}
