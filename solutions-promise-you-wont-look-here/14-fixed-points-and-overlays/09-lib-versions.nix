# lib versions
#
# nixpkgs provides these functions in `lib`: `lib.fix`, `lib.extends` and
# `lib.composeManyExtensions`, which joins a list of overlays into one.
# `lib.makeExtensible` adds an `extend` function to a fixed point. You wrote
# most of them yourself in the previous koans.
{ __, lib }:

let
  base = final: { greeting = "hello"; };
  addWorld = final: prev: { greeting = prev.greeting + " world"; };
  shout = final: prev: { greeting = prev.greeting + "!"; };
in
{
  fix = {
    expr = (lib.fix (self: { a = 1; b = self.a + 1; })).b;
    expected = /*>*/ 2 /*<*/;
  };

  extends = {
    expr = (lib.fix (lib.extends addWorld base)).greeting;
    expected = /*>*/ "hello world" /*<*/;
  };

  compose = {
    expr = (lib.fix (lib.extends (lib.composeManyExtensions [ shout addWorld ]) base)).greeting;
    expected = /*>*/ "hello! world" /*<*/;
  };

  extensible = {
    expr = ((lib.makeExtensible (self: { a = 1; b = self.a + 1; })).extend (final: prev: { a = 10; })).b;
    expected = /*>*/ 11 /*<*/;
  };
}
