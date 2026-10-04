# Application in lists
#
# Spaces separate list elements, and spaces also apply functions. Inside a
# list, the list wins: `[ f 1 ]` has two elements. This is a common bug in
# package lists, as in `[ pkgs.python3.withPackages (ps: [ ps.requests ]) ]`.
{ __ }:

{
  twoElements = {
    expr =
      let
        f = x: x + 1;
      in
      builtins.length [ f 1 ];
    expected = /*>*/ 2 /*<*/;
  };

  oneElement = {
    expr =
      let
        f = x: x + 1;
      in
      [ (f 1) ];
    expected = /*>*/ [ 2 ] /*<*/;
  };

  firstIsFunction = {
    expr =
      let
        f = x: x + 1;
      in
      builtins.typeOf (builtins.head [ f 1 ]);
    expected = /*>*/ "lambda" /*<*/;
  };
}
