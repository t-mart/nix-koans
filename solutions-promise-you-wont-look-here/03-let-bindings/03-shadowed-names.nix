# Shadowed names
#
# An inner binding with the same name as an outer binding "shadows" it. Inside
# the inner `let`, the name refers to the inner value. The outer value does not
# change.
{ __ }:

{
  inner = {
    expr =
      let
        x = 1;
      in
      let
        x = 2;
      in
      x;
    expected = /*>*/ 2 /*<*/;
  };

  outerUnchanged = {
    expr =
      let
        x = 1;
        y =
          let
            x = 10;
          in
          x + 1;
      in
      x + y;
    expected = /*>*/ 12 /*<*/;
  };
}
