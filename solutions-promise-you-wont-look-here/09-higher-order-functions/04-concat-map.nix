# concatMap
#
# `builtins.concatMap f xs` maps each element to a list and joins the lists.
# It can both transform and remove elements. Package code uses it to build
# lists of compiler flags.
{ __ }:

{
  duplicate = {
    expr = builtins.concatMap (x: [ x x ]) [ 1 2 ];
    expected = /*>*/ [ 1 1 2 2 ] /*<*/;
  };

  remove = {
    expr = builtins.concatMap (x: if x > 1 then [ x ] else [ ]) [ 1 2 3 ];
    expected = /*>*/ [ 2 3 ] /*<*/;
  };

  flags = {
    expr = builtins.concatMap (dir: [ "-I" dir ]) [ "include" "src" ];
    expected = /*>*/ [ "-I" "include" "-I" "src" ] /*<*/;
  };
}
