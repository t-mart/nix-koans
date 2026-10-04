# Capstone: basics
#
# This capstone combines integer division, floats, comparison, logic and
# types. Predict the type first, then the value.
{ __ }:

{
  typeOfMixed = {
    expr = builtins.typeOf (7 / 2 * 2.0);
    expected = __;
  };

  valueOfMixed = {
    expr = 7 / 2 * 2.0;
    expected = __;
  };

  divisionCheck = {
    expr = 7 / 2 == 3.5 || 7.0 / 2 == 3.5;
    expected = __;
  };

  typeOfComparison = {
    expr = builtins.typeOf (1 == 1.0);
    expected = __;
  };

  implication = {
    expr = !(null == false) -> 1 < 2;
    expected = __;
  };
}
