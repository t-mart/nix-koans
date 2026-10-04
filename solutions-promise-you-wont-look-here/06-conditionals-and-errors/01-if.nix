# if
#
# `if c then a else b` is an expression: it gives a value, like the ternary
# operator in other languages. The `else` part is mandatory. NixOS modules
# use `if` to choose settings, as in `if cfg.tls then 443 else 80`.
{ __ }:

{
  choose = {
    expr = if 1 < 2 then "yes" else "no";
    expected = /*>*/ "yes" /*<*/;
  };

  inArithmetic = {
    expr = (if false then 1 else 2) + 10;
    expected = /*>*/ 12 /*<*/;
  };

  inString = {
    expr = "power: ${if true then "on" else "off"}";
    expected = /*>*/ "power: on" /*<*/;
  };
}
