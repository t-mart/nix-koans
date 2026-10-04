# sort
#
# `builtins.sort` takes a "less than" function and a list. The function
# decides the order, so the same `sort` handles numbers, strings and sets.
# Strings compare byte by byte, so capital letters come first.
{ __ }:

{
  ascending = {
    expr = builtins.sort (a: b: a < b) [ 3 1 2 ];
    expected = __;
  };

  descending = {
    expr = builtins.sort (a: b: a > b) [ 3 1 2 ];
    expected = __;
  };

  strings = {
    expr = builtins.sort (a: b: a < b) [ "b" "a" "C" ];
    expected = __;
  };

  bySize = {
    expr = map (p: p.name) (
      builtins.sort (a: b: a.size < b.size) [
        { name = "x"; size = 2; }
        { name = "y"; size = 1; }
      ]
    );
    expected = __;
  };
}
