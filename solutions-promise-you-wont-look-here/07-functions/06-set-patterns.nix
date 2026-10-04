# Set patterns
#
# A function can take a set and "destructure" it with a pattern such as
# `{ a, b }:`. Each name in the pattern becomes a binding. Most Nix files are
# functions of this form, as in `{ pkgs, lib, ... }:`.
{ __ }:

{
  sum = {
    expr = ({ a, b }: a + b) { a = 1; b = 2; };
    expected = /*>*/ 3 /*<*/;
  };

  anyOrder = {
    expr =
      let
        greet = { name, greeting }: "${greeting}, ${name}";
      in
      greet { greeting = "Hi"; name = "Nix"; };
    expected = /*>*/ "Hi, Nix" /*<*/;
  };
}
