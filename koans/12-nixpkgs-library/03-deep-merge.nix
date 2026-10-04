# Deep merge
#
# `lib.recursiveUpdate` merges nested sets, where `//` replaces them. Use it
# when two sets of settings share nested parts. When a value is not a set on
# both sides, the right side still wins.
{ __, lib }:

{
  deep = {
    expr = lib.recursiveUpdate { a = { b = 1; c = 2; }; } { a = { b = 3; }; };
    expected = __;
  };

  shallow = {
    expr = { a = { b = 1; c = 2; }; } // { a = { b = 3; }; };
    expected = __;
  };

  notASet = {
    expr = lib.recursiveUpdate { a = 1; } { a = { b = 2; }; };
    expected = __;
  };
}
