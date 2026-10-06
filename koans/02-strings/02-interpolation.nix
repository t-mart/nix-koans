# Interpolation
#
# `${...}` inside a string inserts the value of an expression. This is
# "string interpolation". Nix code builds most scripts and configuration files
# with it. A `$` without braces is plain text, which suits shell variables.
{ __ }:

{
  expression = {
    expr = "type: ${builtins.typeOf 1}";
    expected = "type: int";
  };

  nestedQuotes = {
    expr = "${"Nix" + "OS"} rocks";
    expected = "NixOS rocks";
  };

  plainDollar = {
    expr = "echo $HOME";
    expected = "echo $HOME";
  };
}
