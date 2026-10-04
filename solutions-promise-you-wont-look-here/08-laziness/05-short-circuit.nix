# Short circuit
#
# `&&`, `||` and `->` evaluate their right side only when they need it. This
# is "short-circuit evaluation". Code uses it to guard a check that fails
# otherwise, as in `s ? port && s.port > 0`.
{ __ }:

{
  andSide = {
    expr = false && throw "boom";
    expected = /*>*/ false /*<*/;
  };

  orSide = {
    expr = true || throw "boom";
    expected = /*>*/ true /*<*/;
  };

  implication = {
    expr = false -> throw "boom";
    expected = /*>*/ true /*<*/;
  };

  needed = {
    expr = (builtins.tryEval (true && throw "boom")).success;
    expected = /*>*/ false /*<*/;
  };

  guard = {
    expr =
      let
        s = { };
      in
      s ? port && s.port > 0;
    expected = /*>*/ false /*<*/;
  };
}
