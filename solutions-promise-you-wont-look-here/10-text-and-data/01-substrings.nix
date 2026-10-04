# Substrings
#
# `builtins` has only a few string functions. `builtins.stringLength` counts
# the bytes of a string. `builtins.substring start length s` takes a part of
# a string; a length past the end is not an error.
{ __ }:

{
  length = {
    expr = builtins.stringLength "hello";
    expected = /*>*/ 5 /*<*/;
  };

  start = {
    expr = builtins.substring 0 3 "hello";
    expected = /*>*/ "hel" /*<*/;
  };

  pastTheEnd = {
    expr = builtins.substring 3 100 "hello";
    expected = /*>*/ "lo" /*<*/;
  };
}
