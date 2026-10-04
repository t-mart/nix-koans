# match
#
# `builtins.match regex s` tests a "regular expression" against the whole
# string. It gives `null` when the string does not match. Otherwise, it gives
# a list of the "capture groups", the parts in parentheses.
{ __ }:

{
  wholeString = {
    expr = builtins.match "a" "ab";
    expected = /*>*/ null /*<*/;
  };

  noGroups = {
    expr = builtins.match "a.*" "ab";
    expected = /*>*/ [ ] /*<*/;
  };

  groups = {
    expr = builtins.match "([a-z]+)-([0-9.]+)" "hello-2.12";
    expected = /*>*/ [ "hello" "2.12" ] /*<*/;
  };

  optionalGroup = {
    expr = builtins.match "(x)?y" "y";
    expected = /*>*/ [ null ] /*<*/;
  };
}
