# Extra attributes
#
# A pattern without `...` rejects attributes that it does not name, with an
# error. The "ellipsis" `...` accepts them. NixOS modules start with
# `{ config, pkgs, ... }:` because NixOS passes many more arguments.
{ __ }:

{
  ignored = {
    expr = ({ a, ... }: a) { a = 1; b = 2; };
    expected = __;
  };

  module = {
    expr =
      let
        f = { name, ... }: "Hello, ${name}";
      in
      f { name = "Nix"; unused = true; };
    expected = __;
  };
}
