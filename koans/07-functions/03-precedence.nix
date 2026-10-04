# Precedence
#
# Function application binds tighter than any operator. `f 1 * 2` means
# `(f 1) * 2`. Add parentheses when an argument is an expression.
{ __ }:

{
  applicationFirst = {
    expr =
      let
        inc = x: x + 1;
      in
      inc 1 * 2;
    expected = __;
  };

  parentheses = {
    expr =
      let
        inc = x: x + 1;
      in
      inc (1 * 2);
    expected = __;
  };

  twoCalls = {
    expr =
      let
        f = x: x * 10;
      in
      f 1 + f 2;
    expected = __;
  };
}
