# Overlay order
#
# Overlays apply in list order. Each overlay sees the result of the previous
# ones as `prev`. Two overlays that change the same value can give a different
# result in a different order.
{ __ }:

let
  fix = f: let x = f x; in x;
  extends = overlay: f: final: let prev = f final; in prev // overlay final prev;
  apply = overlays: fix (builtins.foldl' (f: overlay: extends overlay f) base overlays);
  base = final: { greeting = "hello"; };
  addWorld = final: prev: { greeting = prev.greeting + " world"; };
  shout = final: prev: { greeting = prev.greeting + "!"; };
in
{
  worldThenShout = {
    expr = (apply [ addWorld shout ]).greeting;
    expected = __;
  };

  shoutThenWorld = {
    expr = (apply [ shout addWorld ]).greeting;
    expected = __;
  };
}
