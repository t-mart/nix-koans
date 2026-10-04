# Attributes
#
# A set evaluates its values only on demand. nixpkgs holds more than 100,000
# packages in one set. Laziness lets you select one package without the
# evaluation of all the others.
{ __ }:

{
  select = {
    expr = { a = 1; b = throw "boom"; }.a;
    expected = /*>*/ 1 /*<*/;
  };

  names = {
    expr = builtins.attrNames { a = throw "boom"; };
    expected = /*>*/ [ "a" ] /*<*/;
  };

  presence = {
    expr = { a = throw "boom"; } ? a;
    expected = /*>*/ true /*<*/;
  };
}
