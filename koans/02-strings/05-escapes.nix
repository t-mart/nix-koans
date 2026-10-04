# Escapes
#
# A backslash starts an "escape sequence" in a double-quoted string. `\"` is a
# quote, `\n` is a newline, `\\` is a backslash, and `\${` is a literal `${`.
# Shell scripts inside Nix strings need these often.
{ __ }:

{
  quotes = {
    expr = "say " + "\"hi\"";
    expected = __;
  };

  newlineIsNotBackslashN = {
    expr = "\n" == "\\n";
    expected = __;
  };

  literalInterpolation = {
    expr = "\${name}" == "$" + "{name}";
    expected = __;
  };

  harmlessEscape = {
    expr = "\$HOME" == "$HOME";
    expected = __;
  };
}
