# Selection
#
# An "attribute set", or "attrset", maps names to values. Each "attribute"
# ends with a semicolon, and a dot selects one. Nearly everything in Nix is an
# attrset: packages, configurations and the whole nixpkgs collection.
{ __ }:

{
  select = {
    expr = { a = 1; b = 2; }.b;
    expected = 2;
  };

  stringValue = {
    expr = { name = "nix"; }.name;
    expected = "nix";
  };

  nested = {
    expr = { a = { b = 3; }; }.a.b;
    expected = 3;
  };
}
