# Fetchers
#
# Fetchers such as `fetchurl` and `fetchFromGitHub` make fixed-output
# derivations. You give the hash of the download in advance. To find it, set
# `hash = lib.fakeHash;`, build, and copy the correct hash from the error
# message.
{ __, pkgs }:

let
  fetch = url: pkgs.fetchurl { inherit url; hash = pkgs.lib.fakeHash; };
  a = fetch "https://a.example/src.tar.gz";
  mirror = fetch "https://mirror.example/src.tar.gz";
  other = fetch "https://a.example/other.tar.gz";
in
{
  name = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" a.outPath;
    expected = __;
  };

  mirror = {
    expr = a.outPath == mirror.outPath;
    expected = __;
  };

  otherFile = {
    expr = a.outPath == other.outPath;
    expected = __;
  };
}
