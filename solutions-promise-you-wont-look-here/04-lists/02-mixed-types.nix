# Mixed types
#
# Lists in Nix are "heterogeneous": one list can hold values of different
# types. NixOS options usually allow one element type, and the module system
# checks it, as a later section shows.
{ __ }:

{
  listType = {
    expr = builtins.typeOf [ 1 "two" null ];
    expected = /*>*/ "list" /*<*/;
  };

  emptyListType = {
    expr = builtins.typeOf [ ];
    expected = /*>*/ "list" /*<*/;
  };

  mixedEquality = {
    expr = [ true 1 ] == [ true 1.0 ];
    expected = /*>*/ true /*<*/;
  };
}
