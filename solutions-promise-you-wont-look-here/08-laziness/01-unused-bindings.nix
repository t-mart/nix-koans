# Unused bindings
#
# Nix is "lazy": it evaluates an expression only when the result needs its
# value. A binding that the result does not use never runs, even when it
# contains an error.
{ __ }:

{
  unusedThrow = {
    expr =
      let
        x = throw "boom";
      in
      1;
    expected = /*>*/ 1 /*<*/;
  };

  unusedDivision = {
    expr =
      let
        broken = 1 / 0;
      in
      "fine";
    expected = /*>*/ "fine" /*<*/;
  };
}
