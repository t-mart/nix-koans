# Integers
#
# Nix has 64-bit signed integers with the usual operators: +, - and *.
# Multiplication comes before addition, as in school. Configurations use
# integers for ports, sizes and timeouts, as in
# `networking.firewall.allowedTCPPorts = [ 22 ];`.
{ __ }:

{
  addition = {
    expr = 1 + 1;
    expected = /*>*/ 2 /*<*/;
  };

  subtraction = {
    expr = 10 - 15;
    expected = /*>*/ -5 /*<*/;
  };

  multiplication = {
    expr = 6 * 7;
    expected = /*>*/ 42 /*<*/;
  };

  precedence = {
    expr = 2 + 3 * 4;
    expected = /*>*/ 14 /*<*/;
  };
}
