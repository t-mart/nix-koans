# Capstone: functions
#
# This capstone combines set patterns, defaults, recursion and lists.
#
# Replace __ with a function `range`. It takes `{ from ? 0, to }` and gives
# the list of integers from `from` to `to - 1`.
{ __ }:

let
  range = __;
in
{
  fromZero = {
    expr = range { to = 3; };
    expected = [ 0 1 2 ];
  };

  fromTwo = {
    expr = range { from = 2; to = 5; };
    expected = [ 2 3 4 ];
  };

  empty = {
    expr = range { from = 3; to = 3; };
    expected = [ ];
  };
}
