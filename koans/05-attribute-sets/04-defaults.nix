# Defaults
#
# `s.a or d` gives `s.a` when it exists, and `d` otherwise. Configuration code
# uses `or` to read optional settings, as in `cfg.port or 80`.
{ __ }:

{
  absent = {
    expr = { a = 1; }.b or 0;
    expected = __;
  };

  present = {
    expr = { a = 1; }.a or 0;
    expected = __;
  };

  nullIsPresent = {
    expr = { a = null; }.a or 0;
    expected = __;
  };

  absentPath = {
    expr = { }.a.b or "none";
    expected = __;
  };
}
