# toString
#
# Interpolation accepts strings, but not integers: `"${1}"` is an error.
# `toString` converts a value to a string. You need it to put a port number
# into a configuration file, as in `"listen ${toString port}"`.
{ __ }:

{
  integer = {
    expr = toString 42;
    expected = /*>*/ "42" /*<*/;
  };

  interpolated = {
    expr = "port ${toString 22}";
    expected = /*>*/ "port 22" /*<*/;
  };

  resultType = {
    expr = builtins.typeOf (toString 1);
    expected = /*>*/ "string" /*<*/;
  };
}
