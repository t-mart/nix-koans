# Dynamic names
#
# An attribute name can come from an expression in `${...}`. A name with
# spaces or other special characters needs quotes. Code that generates
# configuration from data uses dynamic names.
{ __ }:

{
  define = {
    expr =
      let
        n = "port";
      in
      { ${n} = 22; };
    expected = __;
  };

  select = {
    expr =
      let
        s = { a = 1; };
        n = "a";
      in
      s.${n};
    expected = __;
  };

  quoted = {
    expr = { "a b" = 1; }."a b";
    expected = __;
  };

  computed = {
    expr = { "${"x" + "y"}" = true; };
    expected = __;
  };
}
