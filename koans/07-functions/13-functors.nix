# Functors
#
# A set with a `__functor` attribute works as a function. The functor gets
# the set itself as its first argument, often named `self`. nixpkgs uses this
# trick for values that are both data and functions.
{ __ }:

{
  call = {
    expr =
      let
        counter = {
          count = 1;
          __functor = self: x: self.count + x;
        };
      in
      counter 41;
    expected = __;
  };

  stillASet = {
    expr = builtins.typeOf { __functor = self: x: x; };
    expected = __;
  };
}
