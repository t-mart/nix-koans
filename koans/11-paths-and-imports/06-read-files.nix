# Read files
#
# `builtins.readFile` reads a file into a string. `builtins.readDir` gives a
# set from the names in a directory to their file types. NixOS configurations
# use them to load keys, scripts and whole directories of modules.
{ __ }:

{
  readFile = {
    expr = builtins.readFile ./fixtures/greeting.txt;
    expected = __;
  };

  fileType = {
    expr = (builtins.readDir ./fixtures).plugins;
    expected = __;
  };

  names = {
    expr = builtins.attrNames (builtins.readDir ./fixtures/plugins);
    expected = __;
  };
}
