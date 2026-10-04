# Infinite structures
#
# Laziness allows "infinite" data. A function can describe an endless stream
# of sets, and Nix evaluates only the part that you select.
{ __ }:

let
  naturals = n: { head = n; tail = naturals (n + 1); };
  take = n: s: if n == 0 then [ ] else [ s.head ] ++ take (n - 1) s.tail;
in
{
  select = {
    expr = (naturals 0).tail.tail.head;
    expected = __;
  };

  take = {
    expr = take 3 (naturals 5);
    expected = __;
  };
}
