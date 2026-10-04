# Short circuit
#
# `&&`, `||` and `->` evaluate their right side only when they need it. This
# is "short-circuit evaluation". Code uses it to guard a check that fails
# otherwise, as in `s ? port && s.port > 0`.
{ __ }:

{
  andSide = {
    expr = false && throw "boom";
    expected = __;
  };

  orSide = {
    expr = true || throw "boom";
    expected = __;
  };

  implication = {
    expr = false -> throw "boom";
    expected = __;
  };

  needed = {
    expr = (builtins.tryEval (true && throw "boom")).success;
    expected = __;
  };

  guard = {
    expr =
      let
        s = { };
      in
      s ? port && s.port > 0;
    expected = __;
  };
}
