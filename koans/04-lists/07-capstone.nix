# Capstone: lists
#
# This capstone combines `let`, `++` and list access. Note that a function
# call binds tighter than `-` and `+`.
{ __ }:

{
  last = {
    expr =
      let
        xs = [ "a" "b" "c" ];
      in
      builtins.elemAt xs (builtins.length xs - 1);
    expected = __;
  };

  joined = {
    expr =
      let
        a = [ 1 ];
        b = [ 2 3 ];
        joined = a ++ b;
      in
      builtins.elemAt joined 1 + builtins.length joined;
    expected = __;
  };

  headInTail = {
    expr =
      let
        xs = [ 1 2 1 ];
      in
      builtins.elem (builtins.head xs) (builtins.tail xs);
    expected = __;
  };
}
