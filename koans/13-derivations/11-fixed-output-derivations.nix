# Fixed-output derivations
#
# A "fixed-output derivation" declares the hash of its result in advance. Its
# store path depends only on the name and that hash, not on the URL or the
# builder. Fetchers such as `fetchurl` work in this way, and Nix gives them
# network access in return.
{ __ }:

let
  fetch =
    url: hash:
    derivation {
      name = "source.tar.gz";
      system = "x86_64-linux";
      builder = "/bin/sh";
      inherit url;
      outputHashMode = "flat";
      outputHashAlgo = "sha256";
      outputHash = hash;
    };
  zeros = "0000000000000000000000000000000000000000000000000000000000000000";
  ones = "1111111111111111111111111111111111111111111111111111111111111111";
  a = fetch "https://a.example/src.tar.gz" zeros;
  b = fetch "https://b.example/src.tar.gz" zeros;
  aWithOnes = fetch "https://a.example/src.tar.gz" ones;
in
{
  otherUrl = {
    expr = a.outPath == b.outPath;
    expected = __;
  };

  otherRecipe = {
    expr = a.drvPath == b.drvPath;
    expected = __;
  };

  otherHash = {
    expr = a.outPath == aWithOnes.outPath;
    expected = __;
  };
}
