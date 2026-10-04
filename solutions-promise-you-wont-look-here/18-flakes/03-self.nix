# self
#
# `self` is the result of the flake's own `outputs`. One output can use
# another output through `self`, as in `self.packages`. Nix computes it as a
# fixed point, like `lib.fix`.
{ __, lib }:

let
  flake = {
    outputs =
      { self }:
      {
        lib.greet = name: "Hello, ${name}!";
        message = self.lib.greet "flakes";
      };
  };
  result = lib.fix (self: flake.outputs { inherit self; });
in
{
  message = {
    expr = result.message;
    expected = /*>*/ "Hello, flakes!" /*<*/;
  };

  function = {
    expr = result.lib.greet "you";
    expected = /*>*/ "Hello, you!" /*<*/;
  };

  names = {
    expr = builtins.attrNames result;
    expected = /*>*/ [ "lib" "message" ] /*<*/;
  };
}
