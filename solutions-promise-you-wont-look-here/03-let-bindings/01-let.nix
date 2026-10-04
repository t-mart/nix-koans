# let
#
# `let ... in` gives names to values for the expression after `in`. Each name
# is a "binding". A binding never changes: Nix has no variables that you can
# assign again. Most Nix files start with a `let` block of helper values.
{ __ }:

{
  single = {
    expr =
      let
        x = 1;
      in
      x + 1;
    expected = /*>*/ 2 /*<*/;
  };

  several = {
    expr =
      let
        greeting = "Hello";
        name = "Nix";
      in
      "${greeting}, ${name}!";
    expected = /*>*/ "Hello, Nix!" /*<*/;
  };
}
