# Comparison
#
# `==` and `!=` compare values of any type. Values of different types are
# not equal, with one exception: an integer and a float with the same value
# are equal. `<`, `<=`, `>` and `>=` order numbers.
{ __ }:

{
  intAndFloat = {
    expr = 1 == 1.0;
    expected = true;
  };

  notEqual = {
    expr = 2 != 3;
    expected = true;
  };

  lessThan = {
    expr = 3 < 2;
    expected = false;
  };

  atLeast = {
    expr = 2 >= 2;
    expected = true;
  };

  boolAndInt = {
    expr = true == 1;
    expected = false;
  };
}
