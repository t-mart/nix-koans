# Shallow update
#
# `//` is a "shallow" merge: it replaces a nested set as a whole. It does not
# merge the two nested sets. This surprise causes many bugs in configuration
# code. A later koan shows a "deep" merge.
{ __ }:

{
  replaced = {
    expr = { a = { b = 1; c = 2; }; } // { a = { b = 3; }; };
    expected = __;
  };

  lost = {
    expr = ({ a.b = 1; a.c = 2; } // { a.c = 5; }) ? a.b;
    expected = __;
  };
}
