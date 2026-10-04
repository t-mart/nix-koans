# Access
#
# Nix lists are arrays. `builtins.length` counts the elements, `builtins.head`
# gives the first and `builtins.tail` gives the rest. `builtins.elemAt` takes
# an index that starts at 0. Nix code seldom indexes lists; later koans
# transform whole lists instead.
{ __ }:

{
  length = {
    expr = builtins.length [ 1 2 3 ];
    expected = __;
  };

  head = {
    expr = builtins.head [ "a" "b" ];
    expected = __;
  };

  tail = {
    expr = builtins.tail [ "a" "b" "c" ];
    expected = __;
  };

  elemAt = {
    expr = builtins.elemAt [ "a" "b" "c" ] 1;
    expected = __;
  };
}
