# Module shape
#
# NixOS consists of "modules". A module is a set with `imports`, `options` and
# `config`, or a function that gives such a set. The function form gets
# arguments such as `config`, `lib` and `pkgs`. Your `configuration.nix` is a
# module.
{ __ }:

let
  moduleAsSet = {
    imports = [ ];
    options = { };
    config = { };
  };
  moduleAsFunction = { config, lib, ... }: { config = { }; };
in
{
  setNames = {
    expr = builtins.attrNames moduleAsSet;
    expected = __;
  };

  functionType = {
    expr = builtins.typeOf moduleAsFunction;
    expected = __;
  };

  functionArguments = {
    expr = builtins.functionArgs moduleAsFunction;
    expected = __;
  };
}
