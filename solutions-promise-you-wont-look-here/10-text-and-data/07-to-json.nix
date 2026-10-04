# toJSON
#
# `builtins.toJSON` converts a value to JSON text. The keys come out sorted,
# because Nix sets are sorted. NixOS uses it to generate configuration files
# for many programs. Tip: an indented string avoids the escape of quotes.
{ __ }:

{
  set = {
    expr = builtins.toJSON { b = 1; a = [ true null ]; };
    expected = /*>*/ ''{"a":[true,null],"b":1}'' /*<*/;
  };

  string = {
    expr = builtins.toJSON "hi";
    expected = /*>*/ ''"hi"'' /*<*/;
  };

  list = {
    expr = builtins.toJSON [ 1 2.5 ];
    expected = /*>*/ "[1,2.5]" /*<*/;
  };
}
