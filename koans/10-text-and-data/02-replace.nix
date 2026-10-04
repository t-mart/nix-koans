# Replace
#
# `builtins.replaceStrings from to s` replaces each string of the list `from`
# with the string at the same position in the list `to`. Package code uses it
# to adapt names and paths.
{ __ }:

{
  single = {
    expr = builtins.replaceStrings [ "a" ] [ "o" ] "banana";
    expected = __;
  };

  several = {
    expr = builtins.replaceStrings [ "-" "." ] [ "_" "_" ] "my-pkg.v1";
    expected = __;
  };
}
