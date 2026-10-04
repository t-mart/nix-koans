# filter
#
# `builtins.filter p xs` keeps the elements for which the "predicate" `p`
# gives `true`.
{ __ }:

{
  numbers = {
    expr = builtins.filter (x: x > 1) [ 1 2 3 ];
    expected = __;
  };

  nonEmpty = {
    expr = builtins.filter (s: s != "") [ "a" "" "b" ];
    expected = __;
  };

  byType = {
    expr = builtins.filter (x: builtins.typeOf x == "int") [ 1 "a" 2.0 3 ];
    expected = __;
  };
}
