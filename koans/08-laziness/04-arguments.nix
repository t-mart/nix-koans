# Arguments
#
# Nix passes arguments to functions without their evaluation. A function that
# ignores an argument never evaluates it. This strategy is "call by need".
{ __ }:

{
  ignored = {
    expr = (x: 1) (throw "boom");
    expected = __;
  };

  const = {
    expr =
      let
        const = a: b: a;
      in
      const "kept" (throw "ignored");
    expected = __;
  };

  unusedAttribute = {
    expr = ({ a, b }: a) { a = 1; b = throw "boom"; };
    expected = __;
  };
}
