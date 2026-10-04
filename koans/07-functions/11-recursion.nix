# Recursion
#
# Nix has no loops. A function in a `let` can call itself instead. This is
# "recursion". Each recursive function needs a case that stops it, here an
# `if`. Built-in functions handle most list work, as a later section shows.
{ __ }:

{
  factorial = {
    expr =
      let
        fact = n: if n == 0 then 1 else n * fact (n - 1);
      in
      fact 5;
    expected = __;
  };

  sum = {
    expr =
      let
        sum = xs: if xs == [ ] then 0 else builtins.head xs + sum (builtins.tail xs);
      in
      sum [ 1 2 3 ];
    expected = __;
  };

  countdown = {
    expr =
      let
        countdown = n: if n == 0 then [ 0 ] else [ n ] ++ countdown (n - 1);
      in
      countdown 3;
    expected = __;
  };
}
