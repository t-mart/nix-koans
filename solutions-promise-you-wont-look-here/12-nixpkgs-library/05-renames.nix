# Renames
#
# `lib.mapAttrs'` can change the names as well as the values. Its function
# gives a `{ name; value; }` pair, which `lib.nameValuePair` makes. Compare it
# with `builtins.listToAttrs`.
{ __, lib }:

{
  pair = {
    expr = lib.nameValuePair "a" 1;
    expected = /*>*/ { name = "a"; value = 1; } /*<*/;
  };

  suffix = {
    expr = lib.mapAttrs' (n: v: lib.nameValuePair "${n}-service" v) { web = 1; };
    expected = /*>*/ { web-service = 1; } /*<*/;
  };

  swap = {
    expr = lib.mapAttrs' (n: v: lib.nameValuePair v n) { a = "x"; b = "y"; };
    expected = /*>*/ { x = "a"; y = "b"; } /*<*/;
  };
}
