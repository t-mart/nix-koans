# Positions
#
# `builtins.unsafeGetAttrPos` gives the file, line and column where the source
# defines an attribute. The runner uses it to show where each koan is.
# "Unsafe" means that the result depends on the layout of the source, not only
# on values.
{ __ }:

let
  sample = {
    first = 1;
    second = 2;
  };
  pos = name: builtins.unsafeGetAttrPos name sample;
in
{
  file = {
    expr = baseNameOf (pos "first").file;
    expected = __;
  };

  lines = {
    expr = (pos "second").line - (pos "first").line;
    expected = __;
  };

  attributes = {
    expr = builtins.attrNames (pos "first");
    expected = __;
  };

  absent = {
    expr = pos "third";
    expected = __;
  };
}
