# Capstone: conditionals and errors
#
# This capstone combines `assert`, `if`, `throw` and `tryEval`. Nix code uses
# checks like these to report bad configuration values early.
{ __ }:

{
  goodPort = {
    expr =
      let
        port = 8080;
        checked = assert port > 0; if port < 65536 then port else throw "port too large";
      in
      builtins.tryEval checked;
    expected = {success=true; value=8080;};
  };

  largePort = {
    expr =
      let
        port = 70000;
        checked = assert port > 0; if port < 65536 then port else throw "port too large";
      in
      builtins.tryEval checked;
    expected = {success=false; value=false;};
  };

  zeroPort = {
    expr =
      let
        port = 0;
        checked = assert port > 0; if port < 65536 then port else throw "port too large";
      in
      (builtins.tryEval checked).success;
    expected = false;
  };
}
