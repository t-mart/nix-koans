# Concatenation
#
# `++` joins two lists into a new list. Package lists often grow in this way,
# as in `basePackages ++ extraPackages`. The module system also joins lists
# from many modules.
{ __ }:

{
  join = {
    expr = [ 1 2 ] ++ [ 3 ];
    expected = /*>*/ [ 1 2 3 ] /*<*/;
  };

  emptyLists = {
    expr = [ ] ++ [ ];
    expected = /*>*/ [ ] /*<*/;
  };

  noFlattening = {
    expr = [ [ 1 ] ] ++ [ 2 ];
    expected = /*>*/ [ [ 1 ] 2 ] /*<*/;
  };
}
