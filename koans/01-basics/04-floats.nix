# Floats
#
# A number with a decimal point is a "float". An operation with at least one
# float gives a float. Floats are not exact, like in most languages.
# Configurations seldom use floats; a display scale factor is one example.
{ __ }:

{
  division = {
    expr = 7.0 / 2;
    expected = __;
  };

  mixed = {
    expr = 1 + 0.5;
    expected = __;
  };

  inexact = {
    expr = 0.1 + 0.2 == 0.3;
    expected = __;
  };
}
