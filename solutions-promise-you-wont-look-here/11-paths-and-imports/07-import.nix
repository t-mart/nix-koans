# import
#
# `import ./file.nix` evaluates another Nix file and gives its value. A file
# often holds a function, so code calls the result, as in
# `import ./module.nix { inherit pkgs; }`. Nix projects split code into files
# in this way.
{ __ }:

{
  value = {
    expr = import ./fixtures/answer.nix;
    expected = /*>*/ 42 /*<*/;
  };

  function = {
    expr = builtins.typeOf (import ./fixtures/greet.nix);
    expected = /*>*/ "lambda" /*<*/;
  };

  call = {
    expr = import ./fixtures/greet.nix { name = "Nix"; };
    expected = /*>*/ "Hello, Nix!" /*<*/;
  };
}
