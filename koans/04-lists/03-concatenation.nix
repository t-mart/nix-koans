# Concatenation
#
# `++` joins two lists into a new list. Package lists often grow in this way,
# as in `basePackages ++ extraPackages`. The module system also joins lists
# from many modules.
{ __ }:

{
  join = {
    expr = [ 1 2 ] ++ [ 3 ];
    expected = __;
  };

  emptyLists = {
    expr = [ ] ++ [ ];
    expected = __;
  };

  noFlattening = {
    expr = [ [ 1 ] ] ++ [ 2 ];
    expected = __;
  };
}
