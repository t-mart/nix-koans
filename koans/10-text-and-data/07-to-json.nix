# toJSON
#
# `builtins.toJSON` converts a value to JSON text. The keys come out sorted,
# because Nix sets are sorted. NixOS uses it to generate configuration files
# for many programs. Tip: an indented string avoids the escape of quotes.
{ __ }:

{
  set = {
    expr = builtins.toJSON { b = 1; a = [ true null ]; };
    expected = __;
  };

  string = {
    expr = builtins.toJSON "hi";
    expected = __;
  };

  list = {
    expr = builtins.toJSON [ 1 2.5 ];
    expected = __;
  };
}
