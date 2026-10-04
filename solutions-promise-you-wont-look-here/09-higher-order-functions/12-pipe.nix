# pipe
#
# A "pipeline" passes a value through a list of functions, from the left.
# nixpkgs provides it as `lib.pipe`.
#
# Replace __ with a function `pipe`. It takes a value and a list of
# functions, and applies the functions in order. Use `builtins.foldl'`.
{ __ }:

let
  pipe = /*>*/ value: fns: builtins.foldl' (acc: f: f acc) value fns /*<*/;
in
{
  numbers = {
    expr = pipe 2 [ (x: x + 1) (x: x * 10) ];
    expected = 30;
  };

  noFunctions = {
    expr = pipe "same" [ ];
    expected = "same";
  };

  list = {
    expr = pipe [ 3 1 2 ] [ (builtins.sort (a: b: a < b)) (map toString) builtins.head ];
    expected = "1";
  };
}
