# map
#
# `map f xs` applies the function `f` to each element of `xs`. A function that
# takes another function is a "higher-order function". Nix code uses them in
# place of loops.
{ __ }:

{
  double = {
    expr = map (x: x * 2) [ 1 2 3 ];
    expected = __;
  };

  toStrings = {
    expr = map toString [ 1 2 ];
    expected = __;
  };

  partial = {
    expr =
      let
        prefix = p: s: p + s;
      in
      map (prefix "lib") [ "foo" "bar" ];
    expected = __;
  };
}
