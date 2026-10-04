# String helpers
#
# `lib.strings` holds the string functions that `builtins` lacks, and `lib`
# provides them directly too. `lib.splitString` is simpler than
# `builtins.split`, because it takes a plain separator.
{ __, lib }:

{
  hasPrefix = {
    expr = lib.hasPrefix "lib" "libfoo";
    expected = /*>*/ true /*<*/;
  };

  removePrefix = {
    expr = lib.removePrefix "lib" "libfoo";
    expected = /*>*/ "foo" /*<*/;
  };

  splitString = {
    expr = lib.splitString "," "a,b,c";
    expected = /*>*/ [ "a" "b" "c" ] /*<*/;
  };

  concatMap = {
    expr = lib.concatMapStringsSep ", " toString [ 1 2 ];
    expected = /*>*/ "1, 2" /*<*/;
  };

  toUpper = {
    expr = lib.toUpper "nix";
    expected = /*>*/ "NIX" /*<*/;
  };
}
