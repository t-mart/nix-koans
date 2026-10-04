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
    expected = /*>*/ { port = 22; } /*<*/;
  };

  select = {
    expr =
      let
        s = { a = 1; };
        n = "a";
      in
      s.${n};
    expected = /*>*/ 1 /*<*/;
  };

  quoted = {
    expr = { "a b" = 1; }."a b";
    expected = /*>*/ 1 /*<*/;
  };

  computed = {
    expr = { "${"x" + "y"}" = true; };
    expected = /*>*/ { xy = true; } /*<*/;
  };
}
