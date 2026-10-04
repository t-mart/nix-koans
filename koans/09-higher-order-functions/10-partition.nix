# partition
#
# `builtins.partition p xs` splits a list in two with a predicate. The
# elements that pass go to `right`, and the others go to `wrong`.
{ __ }:

{
  numbers = {
    expr = builtins.partition (x: x > 2) [ 1 2 3 4 ];
    expected = __;
  };

  sets = {
    expr = (builtins.partition (s: s ? broken) [ { broken = true; } { } ]).wrong;
    expected = __;
  };
}
