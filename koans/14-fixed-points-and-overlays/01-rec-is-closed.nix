# rec is closed
#
# Nix resolves the references inside a `rec` set when it creates the set. A
# later update with `//` cannot change them. nixpkgs needs a set that users
# can change afterwards, so its package set does not use `rec`.
{ __ }:

{
  stale = {
    expr = (rec { a = 1; b = a + 1; } // { a = 10; }).b;
    expected = __;
  };

  updated = {
    expr = (rec { a = 1; b = a + 1; } // { a = 10; }).a;
    expected = __;
  };

  greeting = {
    expr =
      let
        s = rec {
          name = "app";
          greeting = "Hello from ${name}";
        };
      in
      (s // { name = "lib"; }).greeting;
    expected = __;
  };
}
