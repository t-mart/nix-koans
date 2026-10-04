# Overlays
#
# An "overlay" is a function `final: prev: { ... }` that changes a package
# set. `prev` is the set before the overlay, and `final` is the set after all
# overlays. nixpkgs users write overlays to add or change packages.
{ __ }:

let
  fix = f: let x = f x; in x;
  base = final: {
    greeting = "hello";
    message = "${final.greeting}, world";
  };
  overlay = final: prev: { greeting = prev.greeting + " there"; };
  result = fix (final: let prev = base final; in prev // overlay final prev);
in
{
  greeting = {
    expr = result.greeting;
    expected = __;
  };

  message = {
    expr = result.message;
    expected = __;
  };

  before = {
    expr = (base result).greeting;
    expected = __;
  };
}
