# toString surprises
#
# `toString` follows old shell conventions. `true` becomes "1", and `false`
# and `null` become the empty string. Floats get six decimal places. Check the
# result before you put a boolean or a float into a configuration file.
{ __ }:

{
  trueValue = {
    expr = toString true;
    expected = __;
  };

  falseValue = {
    expr = toString false;
    expected = __;
  };

  nullValue = {
    expr = toString null;
    expected = __;
  };

  floatValue = {
    expr = toString 1.5;
    expected = __;
  };
}
