# Equality
#
# Two lists are equal when they have equal elements in the same order. Nix
# compares the "structure" of values, not their identity.
{ __ }:

{
  same = {
    expr = [ 1 2 ] == [ 1 2 ];
    expected = /*>*/ true /*<*/;
  };

  otherOrder = {
    expr = [ 1 2 ] == [ 2 1 ];
    expected = /*>*/ false /*<*/;
  };

  nested = {
    expr = [ [ 1 ] ] == [ [ 1 ] ];
    expected = /*>*/ true /*<*/;
  };

  listAndElement = {
    expr = [ 1 ] == 1;
    expected = /*>*/ false /*<*/;
  };
}
