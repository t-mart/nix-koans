{ config, ... }:
{
  imports = [ ./options.nix ];
  greeting = "Hello, ${config.name}!";
}
