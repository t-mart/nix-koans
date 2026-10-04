# extends
#
# `extends` applies one overlay to a function that expects the final set. The
# result is again such a function, so you can apply more overlays and call
# `fix` at the end. nixpkgs has the same function as `lib.extends`.
#
# Replace __ with a function `extends`. It takes an overlay and a function of
# `final`. It gives a new function of `final` with the overlay applied.
{ __ }:

let
  fix = f: let x = f x; in x;
  extends = /*>*/ overlay: f: final: let prev = f final; in prev // overlay final prev /*<*/;
  base = final: { a = 1; b = final.a * 10; };
in
{
  add = {
    expr = (fix (extends (final: prev: { c = final.b + 1; }) base)).c;
    expected = 11;
  };

  change = {
    expr = (fix (extends (final: prev: { a = 2; }) base)).b;
    expected = 20;
  };

  fromPrev = {
    expr = fix (extends (final: prev: { a = prev.a + 1; }) base);
    expected = { a = 2; b = 20; };
  };
}
