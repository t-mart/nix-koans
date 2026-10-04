# Path type
#
# Paths are their own type in Nix. A path literal contains a slash, as in
# `./foo` or `/etc/hosts`. Nix can check and copy the files of a path, so a
# path is not the same as a string.
{ __ }:

{
  relative = {
    expr = builtins.typeOf ./.;
    expected = /*>*/ "path" /*<*/;
  };

  quoted = {
    expr = builtins.typeOf "./.";
    expected = /*>*/ "string" /*<*/;
  };

  absolute = {
    expr = builtins.typeOf /etc/hosts;
    expected = /*>*/ "path" /*<*/;
  };

  notEqual = {
    expr = ./. == "./.";
    expected = /*>*/ false /*<*/;
  };
}
