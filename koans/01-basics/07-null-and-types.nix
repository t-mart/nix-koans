# Null and types
#
# `null` is a value that means "nothing". NixOS options often use it for "not
# set". `builtins` is a set of functions built into Nix. `builtins.typeOf`
# takes a value and gives the name of its type. A space separates a function
# from its argument.
{ __ }:

{
  nullIsNotFalse = {
    expr = null == false;
    expected = false;
  };

  typeOfInteger = {
    expr = builtins.typeOf 1;
    expected = "int";
  };

  typeOfFloat = {
    expr = builtins.typeOf 1.0;
    expected = "float";
  };

  typeOfBoolean = {
    expr = builtins.typeOf true;
    expected = "bool";
  };

  typeOfNull = {
    expr = builtins.typeOf null;
    expected = "null";
  };
}
