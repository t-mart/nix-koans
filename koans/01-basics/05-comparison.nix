# Comparison
#
# `==` and `!=` compare values of any type. Values of different types are
# not equal, with one exception: an integer and a float with the same value
# are equal. `<`, `<=`, `>` and `>=` order numbers.
{ __ }:

{
  intAndFloat = {
    expr = 1 == 1.0;
    expected = __;
  };

  notEqual = {
    expr = 2 != 3;
    expected = __;
  };

  lessThan = {
    expr = 3 < 2;
    expected = __;
  };

  atLeast = {
    expr = 2 >= 2;
    expected = __;
  };

  boolAndInt = {
    expr = true == 1;
    expected = __;
  };
}
