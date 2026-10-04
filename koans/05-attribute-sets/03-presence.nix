# Presence
#
# The `?` operator tells if a set has an attribute. It also accepts a dotted
# path. Selection of an absent attribute is an error, so code checks with `?`
# first.
{ __ }:

{
  present = {
    expr = { a = 1; } ? a;
    expected = __;
  };

  absent = {
    expr = { a = 1; } ? b;
    expected = __;
  };

  path = {
    expr = { a.b = 1; } ? a.b;
    expected = __;
  };

  absentPath = {
    expr = { a.b = 1; } ? a.c;
    expected = __;
  };

  nullCounts = {
    expr = { a = null; } ? a;
    expected = __;
  };
}
