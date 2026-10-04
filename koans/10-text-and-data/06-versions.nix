# Versions
#
# Package names in Nix have the form "name-version". `builtins.parseDrvName`
# splits them. `builtins.compareVersions a b` gives -1, 0 or 1, and compares
# version parts as numbers, unlike `<` on strings.
{ __ }:

{
  parse = {
    expr = builtins.parseDrvName "hello-2.12.1";
    expected = __;
  };

  dashInName = {
    expr = (builtins.parseDrvName "python3-requests-2.31").name;
    expected = __;
  };

  compare = {
    expr = builtins.compareVersions "1.10" "1.9";
    expected = __;
  };

  stringOrder = {
    expr = "1.10" < "1.9";
    expected = __;
  };
}
