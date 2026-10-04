# listToAttrs
#
# `builtins.listToAttrs` makes a set from a list of `{ name; value; }` sets.
# For a duplicate name, the first entry wins. Note that `//` does the
# opposite.
{ __ }:

{
  single = {
    expr = builtins.listToAttrs [ { name = "a"; value = 1; } ];
    expected = __;
  };

  duplicate = {
    expr = builtins.listToAttrs [
      { name = "a"; value = 1; }
      { name = "a"; value = 2; }
    ];
    expected = __;
  };

  fromNames = {
    expr = builtins.listToAttrs (map (n: { name = n; value = true; }) [ "x" "y" ]);
    expected = __;
  };
}
