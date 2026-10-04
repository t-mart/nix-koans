# Escapes in indented strings
#
# Indented strings have their own escapes. `''${` gives a literal `${`, and
# `'''` gives two single quotes. Backslash escapes have no effect in them.
# Bash scripts in Nix use `''${` for shell variables with braces.
{ __ }:

{
  shellVariable = {
    expr = ''echo ''${HOME}'';
    expected = __;
  };

  plainDollar = {
    expr = ''echo $HOME'';
    expected = __;
  };

  twoQuotes = {
    expr = ''it'''s'';
    expected = __;
  };

  noBackslashEscapes = {
    expr = ''a\nb'' == "a\\nb";
    expected = __;
  };
}
