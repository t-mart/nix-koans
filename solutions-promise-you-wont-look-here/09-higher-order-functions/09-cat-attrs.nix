# catAttrs
#
# `builtins.catAttrs name xs` collects the attribute `name` from each set in
# the list `xs`. It skips sets without that attribute.
{ __ }:

{
  names = {
    expr = builtins.catAttrs "name" [
      { name = "a"; }
      { other = 1; }
      { name = "b"; }
    ];
    expected = /*>*/ [ "a" "b" ] /*<*/;
  };

  empty = {
    expr = builtins.catAttrs "x" [ ];
    expected = /*>*/ [ ] /*<*/;
  };
}
