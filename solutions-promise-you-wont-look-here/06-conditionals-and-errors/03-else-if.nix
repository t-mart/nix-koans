# else if
#
# `else if` is not special syntax. It is an `if` expression in the `else`
# part of another `if`. The first true condition decides the value.
{ __ }:

{
  middle = {
    expr =
      let
        score = 75;
      in
      if score >= 90 then "A" else if score >= 70 then "B" else "C";
    expected = /*>*/ "B" /*<*/;
  };

  last = {
    expr =
      let
        score = 50;
      in
      if score >= 90 then "A" else if score >= 70 then "B" else "C";
    expected = /*>*/ "C" /*<*/;
  };
}
