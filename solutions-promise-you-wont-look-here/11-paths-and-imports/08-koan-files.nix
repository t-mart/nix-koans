# Koan files
#
# Each koan file is a function with the pattern `{ __ }:`. The runner,
# `default.nix`, imports each file and calls it with a set that contains
# `__`. Now you know what the first line of each koan means.
{ __ }:

{
  fileIsFunction = {
    expr = builtins.typeOf (import ./08-koan-files.nix);
    expected = /*>*/ "lambda" /*<*/;
  };

  fileArguments = {
    expr = builtins.functionArgs (import ./08-koan-files.nix);
    expected = /*>*/ { __ = false; } /*<*/;
  };

  fileResult = {
    expr = builtins.attrNames (import ./08-koan-files.nix { __ = null; });
    expected = /*>*/ [ "fileArguments" "fileIsFunction" "fileResult" ] /*<*/;
  };
}
