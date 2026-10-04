# Capstone: text and data
#
# This capstone combines indented strings, `split`, `match`, `filter`,
# `listToAttrs` and `toJSON`.
#
# Replace __ with a function `parse`. It takes text with one `key=value` per
# line and gives a set. Empty lines do not count.
{ __ }:

let
  text = ''
    host=example.org
    port=8080
  '';
  parse = /*>*/ text: builtins.listToAttrs (map (line: let m = builtins.match "([^=]+)=(.*)" line; in { name = builtins.elemAt m 0; value = builtins.elemAt m 1; }) (builtins.filter (l: builtins.typeOf l == "string" && l != "") (builtins.split "\n" text))) /*<*/;
in
{
  parsed = {
    expr = parse text;
    expected = { host = "example.org"; port = "8080"; };
  };

  json = {
    expr = builtins.toJSON (parse text);
    expected = ''{"host":"example.org","port":"8080"}'';
  };
}
