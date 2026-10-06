# Order
#
# The bindings of one `let` are "recursive": each binding can use all the
# others. Their order in the source has no effect. Nix computes a value when
# something needs it, not from top to bottom.
{ __ }:

{
  useBeforeDefinition = {
    expr =
      let
        a = b + 1;
        b = 2;
      in
      a;
    expected = 3;
  };

  chain = {
    expr =
      let
        total = price * count;
        count = 3;
        price = 5;
      in
      total;
    expected = 15;
  };
}
