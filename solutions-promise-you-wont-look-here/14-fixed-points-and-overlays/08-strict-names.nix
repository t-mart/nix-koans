# Strict names
#
# To compute `final`, Nix must know the attribute names of each overlay
# result. So an overlay must not choose its attribute names from `final`.
# This overlay gives "infinite recursion":
#
#   final: prev: if final.withExtra then { extra = 1; } else { }
#
# Choose only the values from `final`, and keep the names fixed.
#
# Replace the first __ with a value for `extra`. It must be 1 when
# `final.withExtra` is true, and null otherwise. Then predict the names.
{ __ }:

let
  fix = f: let x = f x; in x;
  extends = overlay: f: final: let prev = f final; in prev // overlay final prev;
  extra = final: prev: { extra = /*>*/ if final.withExtra then 1 else null /*<*/; };
in
{
  enabled = {
    expr = (fix (extends extra (final: { withExtra = true; }))).extra;
    expected = 1;
  };

  disabled = {
    expr = (fix (extends extra (final: { withExtra = false; }))).extra;
    expected = null;
  };

  names = {
    expr = builtins.attrNames (fix (extends extra (final: { withExtra = false; })));
    expected = /*>*/ [ "extra" "withExtra" ] /*<*/;
  };
}
