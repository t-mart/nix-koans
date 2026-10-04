# genList
#
# `builtins.genList f n` makes a list of `n` elements, where element `i` is
# `f i`. Compare it with your `range` function from the functions capstone.
{ __ }:

{
  squares = {
    expr = builtins.genList (i: i * i) 4;
    expected = __;
  };

  empty = {
    expr = builtins.genList (i: i) 0;
    expected = __;
  };

  range = {
    expr = builtins.genList (i: i + 2) 3;
    expected = __;
  };
}
