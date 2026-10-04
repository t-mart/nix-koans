# throw
#
# `throw "message"` stops evaluation with an error. nixpkgs uses it to report
# invalid input, as in `throw "unsupported platform"`. An `if` evaluates only
# the branch that it chooses, so a `throw` in the other branch does nothing.
{ __ }:

{
  otherBranch = {
    expr = if true then "safe" else throw "never";
    expected = /*>*/ "safe" /*<*/;
  };

  nested = {
    expr =
      let
        port = 8080;
      in
      if port < 1 then throw "too small" else if port > 65535 then throw "too large" else port;
    expected = /*>*/ 8080 /*<*/;
  };
}
