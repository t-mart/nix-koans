# Join
#
# `builtins.concatStringsSep sep xs` joins a list of strings with a
# separator. Nix code builds command lines and configuration files from lists
# in this way.
{ __ }:

{
  comma = {
    expr = builtins.concatStringsSep ", " [ "a" "b" "c" ];
    expected = __;
  };

  lines = {
    expr = builtins.concatStringsSep "\n" (map toString [ 1 2 ]);
    expected = __;
  };

  empty = {
    expr = builtins.concatStringsSep "-" [ ];
    expected = __;
  };
}
