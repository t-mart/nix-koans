# Trivial builders
#
# nixpkgs has "trivial builders" that make small derivations from strings.
# `writeText` writes a file, and `writeShellScriptBin` writes an executable
# script into `bin`. NixOS configurations use them for scripts and
# configuration files.
{ __, pkgs }:

let
  motd = pkgs.writeText "motd" "Welcome!";
  greet = pkgs.writeShellScriptBin "greet" "echo hi";
in
{
  textName = {
    expr = motd.name;
    expected = __;
  };

  text = {
    expr = motd.text;
    expected = __;
  };

  otherText = {
    expr = (pkgs.writeText "motd" "Goodbye!").outPath == motd.outPath;
    expected = __;
  };

  scriptProgram = {
    expr = greet.meta.mainProgram;
    expected = __;
  };
}
