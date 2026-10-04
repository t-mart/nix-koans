# with
#
# `with s; e` makes the attributes of `s` visible as names in `e`. Package
# lists use it to avoid a repeated prefix, as in `with pkgs; [ git vim ]`.
{ __ }:

{
  sum = {
    expr = with { a = 1; b = 2; }; a + b;
    expected = __;
  };

  packages = {
    expr =
      let
        pkgs = { git = "git-2.45"; vim = "vim-9.1"; };
      in
      with pkgs; [ git vim ];
    expected = __;
  };
}
