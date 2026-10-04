# split
#
# `builtins.split regex s` cuts a string at each match of a regular
# expression. The result alternates: a string, a list of capture groups, a
# string, and so on. Remove the lists to keep only the parts.
{ __ }:

{
  noGroups = {
    expr = builtins.split "," "a,b";
    expected = __;
  };

  withGroup = {
    expr = builtins.split "(,)" "a,b";
    expected = __;
  };

  parts = {
    expr = builtins.filter (x: builtins.typeOf x == "string") (builtins.split "," "a,b,c");
    expected = __;
  };
}
