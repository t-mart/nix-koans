{ lib, ... }:
{
  options = {
    name = lib.mkOption { type = lib.types.str; };
    greeting = lib.mkOption { type = lib.types.str; };
  };
}
