# inherit
#
# `inherit x;` is short for `x = x;`. `inherit (s) x;` is short for
# `x = s.x;`. Package definitions use it often, as in `inherit pname version;`.
{ __ }:

{
  fromScope = {
    expr =
      let
        x = 1;
      in
      { inherit x; };
    expected = __;
  };

  fromSet = {
    expr =
      let
        s = { a = 1; b = 2; };
      in
      { inherit (s) a; };
    expected = __;
  };

  several = {
    expr =
      let
        pname = "hello";
        version = "1.0";
      in
      { inherit pname version; };
    expected = __;
  };
}
