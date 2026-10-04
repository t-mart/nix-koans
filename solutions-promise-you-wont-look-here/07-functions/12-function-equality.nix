# Function equality
#
# Nix cannot compare functions. `==` with a function gives `false`, even for
# the same function. This is why each koan compares data, not functions.
{ __ }:

{
  itself = {
    expr =
      let
        f = x: x;
      in
      f == f;
    expected = /*>*/ false /*<*/;
  };

  sameSource = {
    expr = (x: x) == (x: x);
    expected = /*>*/ false /*<*/;
  };

  results = {
    expr =
      let
        f = x: x;
      in
      f 1 == f 1;
    expected = /*>*/ true /*<*/;
  };
}
