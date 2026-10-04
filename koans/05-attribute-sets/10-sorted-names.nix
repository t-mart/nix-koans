# Sorted names
#
# Nix keeps the attributes of a set in sorted order, and the source order is
# lost. `builtins.attrNames` and `builtins.attrValues` follow the sorted order.
# Capital letters sort before small letters.
{ __ }:

{
  names = {
    expr = builtins.attrNames { b = 1; a = 2; };
    expected = __;
  };

  values = {
    expr = builtins.attrValues { b = 1; a = 2; };
    expected = __;
  };

  capitals = {
    expr = builtins.attrNames { z = 1; Z = 2; };
    expected = __;
  };
}
