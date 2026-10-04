# fix
#
# A "fixed point" of a function `f` is a value `x` with `x == f x`. Laziness
# lets Nix compute it: the function gets its own result as an argument, often
# named `self`. This small function is the heart of nixpkgs.
#
# Replace __ with a function `fix`. It takes `f` and gives `x` such that
# `x = f x`. Hint: a `let` binding can refer to itself.
{ __ }:

let
  fix = /*>*/ f: let x = f x; in x /*<*/;
in
{
  set = {
    expr = (fix (self: { a = 1; b = self.a + 1; })).b;
    expected = 2;
  };

  strings = {
    expr = (fix (self: { name = "nix"; greeting = "hello ${self.name}"; })).greeting;
    expected = "hello nix";
  };

  list = {
    expr = fix (self: [ 1 (builtins.head self + 1) ]);
    expected = [ 1 2 ];
  };
}
