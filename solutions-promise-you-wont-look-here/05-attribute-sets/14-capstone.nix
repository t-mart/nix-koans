# Capstone: attribute sets
#
# This capstone combines `//`, nested keys, `inherit`, `or` and sorted names.
# It shows how a shallow merge loses nested defaults.
{ __ }:

let
  defaults = {
    port = 80;
    host = "localhost";
    tls = { enable = false; cert = "none"; };
  };
  user = {
    port = 8080;
    tls.enable = true;
  };
  merged = defaults // user;
in
{
  names = {
    expr = builtins.attrNames merged;
    expected = /*>*/ [ "host" "port" "tls" ] /*<*/;
  };

  tls = {
    expr = merged.tls;
    expected = /*>*/ { enable = true; } /*<*/;
  };

  cert = {
    expr = merged.tls.cert or "lost";
    expected = /*>*/ "lost" /*<*/;
  };

  port = {
    expr = { inherit (merged) port; };
    expected = /*>*/ { port = 8080; } /*<*/;
  };
}
