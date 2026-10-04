# Capstone: paths and imports
#
# This capstone combines `readDir`, `filter`, `match`, `listToAttrs` and
# `import`. NixOS configurations often load all modules of a directory in this
# way.
#
# Replace __ with a function `importDir`. It takes a directory and gives a
# set with one attribute for each `.nix` file in it. The name is the file name
# without `.nix`, and the value is the imported file.
{ __ }:

let
  importDir = __;
in
{
  plugins = {
    expr = importDir ./fixtures/plugins;
    expected = {
      alpha = { name = "alpha"; priority = 2; };
      beta = { name = "beta"; priority = 1; };
    };
  };
}
