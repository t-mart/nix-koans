# Discard context
#
# `builtins.unsafeDiscardStringContext` removes the context. The text stays
# the same, but Nix forgets the dependency. A build that uses such a string can
# fail, because Nix does not provide the dependency to it.
{ __ }:

let
  drv = derivation { name = "hello"; system = "x86_64-linux"; builder = "/bin/sh"; };
  mk =
    script:
    derivation {
      name = "app";
      system = "x86_64-linux";
      builder = "/bin/sh";
      args = [ "-c" script ];
    };
  plain = builtins.unsafeDiscardStringContext "${drv}";
in
{
  removed = {
    expr = builtins.hasContext plain;
    expected = __;
  };

  sameText = {
    expr = plain == drv.outPath;
    expected = __;
  };

  differentRecipe = {
    expr = (mk "cat ${plain}").outPath == (mk "cat ${drv}").outPath;
    expected = __;
  };
}
