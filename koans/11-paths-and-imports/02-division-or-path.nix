# Division or path
#
# A slash without spaces makes a path, even between numbers or names. So
# `a/b` is a path, but `a / b` is a division. This is why you put spaces
# around the division operator.
{ __ }:

{
  numbers = {
    expr = builtins.typeOf 7/2;
    expected = __;
  };

  spaces = {
    expr = builtins.typeOf (7 / 2);
    expected = __;
  };

  names = {
    expr =
      let
        a = 6;
        b = 2;
      in
      builtins.typeOf a/b;
    expected = __;
  };
}
