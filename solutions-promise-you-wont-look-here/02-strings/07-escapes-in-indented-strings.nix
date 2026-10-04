# Escapes in indented strings
#
# Indented strings have their own escapes. `''${` gives a literal `${`, and
# `'''` gives two single quotes. Backslash escapes have no effect in them.
# Bash scripts in Nix use `''${` for shell variables with braces.
{ __ }:

{
  shellVariable = {
    expr = ''echo ''${HOME}'';
    expected = /*>*/ "echo \${HOME}" /*<*/;
  };

  plainDollar = {
    expr = ''echo $HOME'';
    expected = /*>*/ "echo $HOME" /*<*/;
  };

  twoQuotes = {
    expr = ''it'''s'';
    expected = /*>*/ "it''s" /*<*/;
  };

  noBackslashEscapes = {
    expr = ''a\nb'' == "a\\nb";
    expected = /*>*/ true /*<*/;
  };
}
