# A tiny stand-in for nixpkgs. Like the real one, it is a function of
# `system` and `overlays` that gives a package set.
{
  system,
  overlays ? [ ],
}:
let
  fix = f: let x = f x; in x;
  extends = overlay: f: final: let prev = f final; in prev // overlay final prev;
  base = final: {
    hello = {
      name = "hello";
      inherit system;
    };
  };
in
fix (builtins.foldl' (f: overlay: extends overlay f) base overlays)
