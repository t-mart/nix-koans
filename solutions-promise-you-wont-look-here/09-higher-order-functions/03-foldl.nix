# foldl'
#
# `builtins.foldl' f init xs` "reduces" a list to one value. It calls `f` with
# an "accumulator" and each element, from the left. The apostrophe means that
# it evaluates the accumulator at each step.
{ __ }:

{
  sum = {
    expr = builtins.foldl' (acc: x: acc + x) 0 [ 1 2 3 ];
    expected = /*>*/ 6 /*<*/;
  };

  join = {
    expr = builtins.foldl' (acc: x: acc + x) "" [ "a" "b" ];
    expected = /*>*/ "ab" /*<*/;
  };

  reverse = {
    expr = builtins.foldl' (acc: x: [ x ] ++ acc) [ ] [ 1 2 3 ];
    expected = /*>*/ [ 3 2 1 ] /*<*/;
  };

  mergeSets = {
    expr = builtins.foldl' (acc: s: acc // s) { } [ { a = 1; } { a = 2; b = 3; } ];
    expected = /*>*/ { a = 2; b = 3; } /*<*/;
  };
}
