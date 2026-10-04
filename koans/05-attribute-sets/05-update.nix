# Update
#
# The "update" operator `//` combines two sets into a new set. For a name in
# both sets, the right side wins. Nix code uses it to change a few attributes
# of a larger set.
{ __ }:

{
  combine = {
    expr = { a = 1; } // { b = 2; };
    expected = __;
  };

  rightWins = {
    expr = { a = 1; } // { a = 2; };
    expected = __;
  };

  chain = {
    expr = { a = 1; } // { a = 2; } // { a = 3; };
    expected = __;
  };
}
