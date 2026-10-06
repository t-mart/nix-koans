# Booleans
#
# Each koan has an expression (expr) and your prediction of its value
# (expected). Replace each __ with the value of expr.
#
# Nix is a pure, lazy, functional language. A Nix file holds one expression,
# and evaluation gives one value. The simplest values are the booleans "true"
# and "false". NixOS configurations use them to turn features on and off, as
# in `services.openssh.enable = true;`.
#
# You will learn what the next line means later.
{ __ }:

{
  truth = {
    expr = true;
    expected = true;
  };

  falsehood = {
    expr = false;
    expected = false;
  };
}
