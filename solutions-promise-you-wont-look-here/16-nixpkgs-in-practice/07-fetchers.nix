# Fetchers
#
# Fetchers such as `fetchurl` and `fetchFromGitHub` make fixed-output
# derivations. You give the hash of the download in advance. To find it, set
# `hash = lib.fakeHash;`, build, and copy the correct hash from the error
# message.
{ __, pkgs }:

let
  fetch = url: pkgs.fetchurl { inherit url; hash = pkgs.lib.fakeHash; };
in
{
  name = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" (fetch "https://a.example/src.tar.gz").outPath;
    expected = /*>*/ [ "src.tar.gz" ] /*<*/;
  };

  mirror = {
    expr = (fetch "https://a.example/src.tar.gz").outPath == (fetch "https://mirror.example/src.tar.gz").outPath;
    expected = /*>*/ true /*<*/;
  };

  otherFile = {
    expr = (fetch "https://a.example/src.tar.gz").outPath == (fetch "https://a.example/other.tar.gz").outPath;
    expected = /*>*/ false /*<*/;
  };
}
