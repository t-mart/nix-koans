# Integer division
#
# The / operator on two integers gives an integer. It discards the remainder
# and rounds toward zero. Nix has no remainder operator, so code computes it
# from division. Always put spaces around /. A later koan shows why.
{ __ }:

{
  exact = {
    expr = 6 / 3;
    expected = __;
  };

  truncated = {
    expr = 7 / 2;
    expected = __;
  };

  negative = {
    expr = -7 / 2;
    expected = __;
  };

  remainder = {
    expr = 7 - 7 / 2 * 2;
    expected = __;
  };
}
