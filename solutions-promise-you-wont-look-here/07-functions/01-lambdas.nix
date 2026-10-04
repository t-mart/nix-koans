# Lambdas
#
# A function in Nix is a "lambda": `x: x + 1` takes one argument `x`. A space
# applies a function to an argument, so `f 1` calls `f` with `1`. Functions
# have no names of their own; a `let` binding gives them one.
{ __ }:

{
  inline = {
    expr = (x: x + 1) 1;
    expected = /*>*/ 2 /*<*/;
  };

  named = {
    expr =
      let
        double = x: x * 2;
      in
      double 21;
    expected = /*>*/ 42 /*<*/;
  };

  stringResult = {
    expr =
      let
        greet = name: "Hello, ${name}!";
      in
      greet "Nix";
    expected = /*>*/ "Hello, Nix!" /*<*/;
  };
}
