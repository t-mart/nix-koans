# Literals
#
# A list holds values in order. Spaces separate the elements; there are no
# commas. An element that is an operation needs parentheses. NixOS uses lists
# for packages, as in `environment.systemPackages = [ pkgs.git pkgs.vim ];`.
{ __ }:

{
  numbers = {
    expr = [ (1 + 1) 3 ];
    expected = __;
  };

  nested = {
    expr = [ [ 1 ] [ ] ] == [ [ 1 ] [ ] ];
    expected = __;
  };

  empty = {
    expr = [ ] == [ ];
    expected = __;
  };
}
