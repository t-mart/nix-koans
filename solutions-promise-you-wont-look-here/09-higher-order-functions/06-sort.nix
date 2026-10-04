# sort
#
# `builtins.sort` takes a "less than" function and a list. The function
# decides the order, so the same `sort` handles numbers, strings and sets.
# Strings compare byte by byte, so capital letters come first.
{ __ }:

{
  ascending = {
    expr = builtins.sort (a: b: a < b) [ 3 1 2 ];
    expected = /*>*/ [ 1 2 3 ] /*<*/;
  };

  descending = {
    expr = builtins.sort (a: b: a > b) [ 3 1 2 ];
    expected = /*>*/ [ 3 2 1 ] /*<*/;
  };

  strings = {
    expr = builtins.sort (a: b: a < b) [ "b" "a" "C" ];
    expected = /*>*/ [ "C" "a" "b" ] /*<*/;
  };

  bySize = {
    expr = map (p: p.name) (
      builtins.sort (a: b: a.size < b.size) [
        { name = "x"; size = 2; }
        { name = "y"; size = 1; }
      ]
    );
    expected = /*>*/ [ "y" "x" ] /*<*/;
  };
}
