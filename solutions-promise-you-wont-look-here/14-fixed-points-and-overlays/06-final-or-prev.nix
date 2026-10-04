# final or prev
#
# Use `prev` to change a value in terms of its old value, as in
# `version = prev.version + 1`. With `final`, that definition refers to
# itself, and Nix reports "infinite recursion". Use `final` to see the result
# of all overlays, including later ones.
#
# Replace each __ with `final` or `prev`.
{ __ }:

let
  fix = f: let x = f x; in x;
  extends = overlay: f: final: let prev = f final; in prev // overlay final prev;
  base = final: { name = "nix"; version = 1; };
  greet = final: prev: { greeting = "hello ${(/*>*/ final /*<*/).name}"; };
  rename = final: prev: { name = "NixOS"; };
  bump = final: prev: { version = (/*>*/ prev /*<*/).version + 1; };
  result = fix (extends bump (extends rename (extends greet base)));
in
{
  greeting = {
    expr = result.greeting;
    expected = "hello NixOS";
  };

  version = {
    expr = result.version;
    expected = 2;
  };
}
