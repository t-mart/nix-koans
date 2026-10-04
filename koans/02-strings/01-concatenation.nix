# Concatenation
#
# Strings hold text between double quotes. `+` joins two strings, which is
# "concatenation". NixOS configurations are full of strings: host names,
# commands and whole configuration files.
{ __ }:

{
  greeting = {
    expr = "Hello, " + "world";
    expected = __;
  };

  digits = {
    expr = "1" + "1";
    expected = __;
  };

  empty = {
    expr = "" + "nix" + "";
    expected = __;
  };
}
