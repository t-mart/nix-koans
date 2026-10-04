# List elements
#
# A list is lazy in its elements, but not in its length. Nix knows how many
# elements a list has without the evaluation of any of them.
{ __ }:

{
  length = {
    expr = builtins.length [ (throw "a") (throw "b") ];
    expected = /*>*/ 2 /*<*/;
  };

  head = {
    expr = builtins.head [ 1 (throw "boom") ];
    expected = /*>*/ 1 /*<*/;
  };

  elemAt = {
    expr = builtins.elemAt [ (throw "boom") 2 ] 1;
    expected = /*>*/ 2 /*<*/;
  };
}
