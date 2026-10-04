# Nested keys
#
# A dotted name such as `a.b = 1;` creates nested sets. Two dotted names with
# the same start merge into one nested set. NixOS configurations use this
# form all the time, as in `services.openssh.enable = true;`.
{ __ }:

{
  dotted = {
    expr = { a.b = 1; };
    expected = /*>*/ { a = { b = 1; }; } /*<*/;
  };

  merged = {
    expr = { a.b = 1; a.c = 2; };
    expected = /*>*/ { a = { b = 1; c = 2; }; } /*<*/;
  };

  deep = {
    expr = { services.nginx.enable = true; }.services.nginx.enable;
    expected = /*>*/ true /*<*/;
  };
}
