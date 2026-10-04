# Find the koans
#
# The runner, `default.nix`, finds the koans with `readDir`, `filter` and
# `match`. It keeps only names that start with a digit, so it skips
# directories such as `fixtures`. The numbers in the names make the sorted
# order the same as the curriculum order.
{ __ }:

let
  # From default.nix:
  numbered =
    dir:
    map (name: dir + "/${name}") (
      builtins.filter (name: builtins.match "[0-9].*" name != null) (
        builtins.attrNames (builtins.readDir dir)
      )
    );
in
{
  sectionCount = {
    expr = builtins.length (numbered ../.);
    expected = __;
  };

  firstSection = {
    expr = baseNameOf (builtins.head (numbered ../.));
    expected = __;
  };

  thisFile = {
    expr = baseNameOf (builtins.head (numbered ./.));
    expected = __;
  };

  fixturesExist = {
    expr = (builtins.readDir ../11-paths-and-imports) ? fixtures;
    expected = __;
  };

  fixturesSkipped = {
    expr = builtins.elem "fixtures" (map baseNameOf (numbered ../11-paths-and-imports));
    expected = __;
  };
}
