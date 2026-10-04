# Capstone: functions
#
# This capstone combines set patterns, defaults, recursion and lists.
#
# Replace __ with a function `range`. It takes `{ from ? 0, to }` and gives
# the list of integers from `from` up to, but not including, `to`.
{ __ }:

let
  range = /*>*/ { from ? 0, to }: if from >= to then [ ] else [ from ] ++ range { from = from + 1; inherit to; } /*<*/;
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
