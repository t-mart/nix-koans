# Update
#
# The "update" operator `//` combines two sets into a new set. For a name in
# both sets, the right side wins. Nix code uses it to change a few attributes
# of a larger set.
{ __ }:

{
  combine = {
    expr = { a = 1; } // { b = 2; };
    expected = /*>*/ { a = 1; b = 2; } /*<*/;
  };

  rightWins = {
    expr = { a = 1; } // { a = 2; };
    expected = /*>*/ { a = 2; } /*<*/;
  };

  chain = {
    expr = { a = 1; } // { a = 2; } // { a = 3; };
    expected = /*>*/ { a = 3; } /*<*/;
  };
}
