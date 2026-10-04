# Removal
#
# `builtins.removeAttrs s names` gives a copy of `s` without the listed names.
# A set never changes; each operation gives a new set. A name that `s` lacks
# is not an error.
{ __ }:

{
  remove = {
    expr = builtins.removeAttrs { a = 1; b = 2; } [ "a" ];
    expected = __;
  };

  absentName = {
    expr = builtins.removeAttrs { a = 1; } [ "z" ];
    expected = __;
  };

  original = {
    expr =
      let
        s = { a = 1; b = 2; };
        t = builtins.removeAttrs s [ "a" ];
      in
      s ? a;
    expected = __;
  };
}
