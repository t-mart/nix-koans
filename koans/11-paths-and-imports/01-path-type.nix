# Path type
#
# Paths are their own type in Nix. A path literal contains a slash, as in
# `./foo` or `/etc/hosts`. Nix can check and copy the files of a path, so a
# path is not the same as a string.
{ __ }:

{
  relative = {
    expr = builtins.typeOf ./.;
    expected = __;
  };

  quoted = {
    expr = builtins.typeOf "./.";
    expected = __;
  };

  absolute = {
    expr = builtins.typeOf /etc/hosts;
    expected = __;
  };

  notEqual = {
    expr = ./. == "./.";
    expected = __;
  };
}
