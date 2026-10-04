# Attribute paths
#
# An "attribute path" is a list of names, such as
# `[ "services" "nginx" "enable" ]`. These functions read and make nested sets
# from such lists. The module system uses attribute paths for option names.
{ __, lib }:

{
  read = {
    expr = lib.attrByPath [ "a" "b" ] 0 { a.b = 5; };
    expected = __;
  };

  readAbsent = {
    expr = lib.attrByPath [ "a" "x" ] 0 { a.b = 5; };
    expected = __;
  };

  make = {
    expr = lib.setAttrByPath [ "services" "nginx" "enable" ] true;
    expected = __;
  };
}
