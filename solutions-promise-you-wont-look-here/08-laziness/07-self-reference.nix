# Self-reference
#
# A `let` binding can refer to itself. Laziness makes this work: Nix computes
# `s.b` only when you select it, and by then `s` exists. NixOS configurations
# and nixpkgs both rely on this idea.
{ __ }:

{
  set = {
    expr =
      let
        s = { a = 1; b = s.a + 1; };
      in
      s.b;
    expected = /*>*/ 2 /*<*/;
  };

  config = {
    expr =
      let
        config = {
          port = 80;
          url = "http://localhost:${toString config.port}";
        };
      in
      config.url;
    expected = /*>*/ "http://localhost:80" /*<*/;
  };

  list = {
    expr =
      let
        xs = [ 1 (builtins.head xs + 1) ];
      in
      builtins.elemAt xs 1;
    expected = /*>*/ 2 /*<*/;
  };
}
