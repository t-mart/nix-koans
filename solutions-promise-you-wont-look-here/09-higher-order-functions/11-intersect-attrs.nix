# intersectAttrs
#
# `builtins.intersectAttrs a b` keeps the attributes of `b` whose names also
# appear in `a`. The values in `a` have no effect. Remember this function for
# a later koan about package sets.
{ __ }:

{
  keep = {
    expr = builtins.intersectAttrs { a = null; } { a = 1; b = 2; };
    expected = /*>*/ { a = 1; } /*<*/;
  };

  valuesFromSecond = {
    expr = builtins.intersectAttrs { a = "ignored"; } { a = "kept"; };
    expected = /*>*/ { a = "kept"; } /*<*/;
  };

  nothingShared = {
    expr = builtins.intersectAttrs { x = true; } { y = 1; };
    expected = /*>*/ { } /*<*/;
  };

  withFunctionArgs = {
    expr = builtins.intersectAttrs (builtins.functionArgs ({ git, ... }: git)) {
      git = "git-2.45";
      vim = "vim-9.1";
    };
    expected = /*>*/ { git = "git-2.45"; } /*<*/;
  };
}
