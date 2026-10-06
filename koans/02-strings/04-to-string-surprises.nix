# toString surprises
#
# `toString` follows old shell conventions. `true` becomes "1", and `false`
# and `null` become the empty string. Floats get six decimal places. Check the
# result before you put a boolean or a float into a configuration file.
{ __ }:

{
  trueValue = {
    expr = toString true;
    expected = "1";
  };

  falseValue = {
    expr = toString false;
    expected = "";
  };

  nullValue = {
    expr = toString null;
    expected = "";
  };

  floatValue = {
    expr = toString 1.5;
    expected = "1.500000";
  };
}
