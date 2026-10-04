# split
#
# `builtins.split regex s` cuts a string at each match of a regular
# expression. The result alternates: a string, a list of capture groups, a
# string, and so on. Remove the lists to keep only the parts.
{ __ }:

{
  noGroups = {
    expr = builtins.split "," "a,b";
    expected = /*>*/ [ "a" [ ] "b" ] /*<*/;
  };

  withGroup = {
    expr = builtins.split "(,)" "a,b";
    expected = /*>*/ [ "a" [ "," ] "b" ] /*<*/;
  };

  parts = {
    expr = builtins.filter (x: builtins.typeOf x == "string") (builtins.split "," "a,b,c");
    expected = /*>*/ [ "a" "b" "c" ] /*<*/;
  };
}
