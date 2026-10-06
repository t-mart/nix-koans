# Membership
#
# `builtins.elem x xs` is `true` when the list `xs` contains `x`. It compares
# with `==`, so the rules from the comparison koan apply. Package metadata uses
# such checks, for example to see if a package supports a platform.
{ __ }:

{
  present = {
    expr = builtins.elem 2 [ 1 2 3 ];
    expected = true;
  };

  differentType = {
    expr = builtins.elem "2" [ 1 2 3 ];
    expected = false;
  };

  floatMatchesInt = {
    expr = builtins.elem 2.0 [ 1 2 ];
    expected = true;
  };

  nestedList = {
    expr = builtins.elem [ 1 ] [ [ 1 ] ];
    expected = true;
  };
}
