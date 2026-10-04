# Defaults
#
# `a ? 1` in a pattern gives `a` a "default value" for a call without `a`. A
# default can use the other arguments. Package functions use defaults for
# optional features, as in `{ withGui ? false }:`.
{ __ }:

{
  absent = {
    expr = ({ a ? 1 }: a) { };
    expected = __;
  };

  present = {
    expr = ({ a ? 1 }: a) { a = 5; };
    expected = __;
  };

  greeting = {
    expr = ({ name, greeting ? "Hello" }: "${greeting}, ${name}") { name = "Nix"; };
    expected = __;
  };

  fromOtherArgument = {
    expr = ({ a, b ? a * 2 }: b) { a = 3; };
    expected = __;
  };
}
