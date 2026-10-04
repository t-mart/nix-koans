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
    expected = __;
  };

  typeOfInteger = {
    expr = builtins.typeOf 1;
    expected = __;
  };

  typeOfFloat = {
    expr = builtins.typeOf 1.0;
    expected = __;
  };

  typeOfBoolean = {
    expr = builtins.typeOf true;
    expected = __;
  };

  typeOfNull = {
    expr = builtins.typeOf null;
    expected = __;
  };
}
