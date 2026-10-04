# Capstone: the nixpkgs library
#
# This capstone repeats the higher-order functions capstone with `lib`.
# Compare the two versions.
#
# Replace the first __ with an expression that uses `lib.pipe`. It must give
# a set from the name to the version of each enabled package. Then predict
# the summary.
{ __, lib }:

let
  packages = [
    { name = "git"; enable = true; version = "2.45"; }
    { name = "vim"; enable = false; version = "9.1"; }
    { name = "jq"; enable = true; version = "1.7"; }
  ];
  enabledByName = __;
in
{
  result = {
    expr = enabledByName;
    expected = { git = "2.45"; jq = "1.7"; };
  };

  summary = {
    expr = lib.concatStringsSep ", " (lib.mapAttrsToList (n: v: "${n} ${v}") enabledByName);
    expected = __;
  };
}
