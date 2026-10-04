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
    expected = __;
  };

  subtraction = {
    expr = 10 - 15;
    expected = __;
  };

  multiplication = {
    expr = 6 * 7;
    expected = __;
  };

  precedence = {
    expr = 2 + 3 * 4;
    expected = __;
  };
}
