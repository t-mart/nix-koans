# Join
#
# `builtins.concatStringsSep sep xs` joins a list of strings with a
# separator. Nix code builds command lines and configuration files from lists
# in this way.
{ __ }:

{
  comma = {
    expr = builtins.concatStringsSep ", " [ "a" "b" "c" ];
    expected = /*>*/ "a, b, c" /*<*/;
  };

  lines = {
    expr = builtins.concatStringsSep "\n" (map toString [ 1 2 ]);
    expected = /*>*/ "1\n2" /*<*/;
  };

  empty = {
    expr = builtins.concatStringsSep "-" [ ];
    expected = /*>*/ "" /*<*/;
  };
}
