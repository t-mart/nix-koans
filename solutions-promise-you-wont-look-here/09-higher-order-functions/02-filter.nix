# filter
#
# `builtins.filter p xs` keeps the elements for which the "predicate" `p`
# gives `true`.
{ __ }:

{
  numbers = {
    expr = builtins.filter (x: x > 1) [ 1 2 3 ];
    expected = /*>*/ [ 2 3 ] /*<*/;
  };

  nonEmpty = {
    expr = builtins.filter (s: s != "") [ "a" "" "b" ];
    expected = /*>*/ [ "a" "b" ] /*<*/;
  };

  byType = {
    expr = builtins.filter (x: builtins.typeOf x == "int") [ 1 "a" 2.0 3 ];
    expected = /*>*/ [ 1 3 ] /*<*/;
  };
}
