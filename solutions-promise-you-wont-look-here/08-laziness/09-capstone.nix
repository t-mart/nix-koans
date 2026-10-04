# Capstone: laziness
#
# This capstone combines lazy sets, self-reference, `or` and `tryEval`.
# nixpkgs works in the same way: one broken package does not affect the other
# packages.
{ __ }:

let
  pkgs = {
    hello = { name = "hello"; version = "2.12"; };
    broken = throw "broken: this package does not build on your platform";
    greeting = "${pkgs.hello.name}-${pkgs.hello.version}";
  };
in
{
  greeting = {
    expr = pkgs.greeting;
    expected = /*>*/ "hello-2.12" /*<*/;
  };

  absent = {
    expr = pkgs.missing or "absent";
    expected = /*>*/ "absent" /*<*/;
  };

  broken = {
    expr = (builtins.tryEval pkgs.broken).success;
    expected = /*>*/ false /*<*/;
  };

  count = {
    expr = builtins.length (builtins.attrNames pkgs);
    expected = /*>*/ 3 /*<*/;
  };
}
