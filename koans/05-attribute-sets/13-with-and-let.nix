# with and let
#
# A name from `with` has the lowest priority. A `let` binding or a function
# argument wins, even from an outer scope. The innermost `with` wins over
# outer ones. Many Nix users avoid `with` because of these rules.
{ __ }:

{
  letWins = {
    expr =
      let
        x = 1;
      in
      with { x = 2; }; x;
    expected = __;
  };

  innerWithWins = {
    expr = with { x = 1; }; with { x = 2; }; x;
    expected = __;
  };
}
