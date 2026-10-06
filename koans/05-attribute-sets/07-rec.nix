# rec
#
# In a `rec` set, the attributes can refer to each other, like the bindings of
# a `let`. Many style guides prefer `let`, because `rec` has a trap that a
# later koan shows.
{ __ }:

{
  sum = {
    expr = rec { a = 1; b = a + 1; }.b;
    expected = 2;
  };

  greeting = {
    expr = rec { name = "Nix"; greeting = "Hello, ${name}"; }.greeting;
    expected = "Hello, Nix";
  };
}
