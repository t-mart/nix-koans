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
    expected = /*>*/ { x = 1; } /*<*/;
  };

  fromSet = {
    expr =
      let
        s = { a = 1; b = 2; };
      in
      { inherit (s) a; };
    expected = /*>*/ { a = 1; } /*<*/;
  };

  several = {
    expr =
      let
        pname = "hello";
        version = "1.0";
      in
      { inherit pname version; };
    expected = /*>*/ { pname = "hello"; version = "1.0"; } /*<*/;
  };
}
