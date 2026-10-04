# getExe
#
# `lib.getExe` gives the path of the main program of a package, from
# `meta.mainProgram`. `lib.getExe'` takes the program name as an argument.
# NixOS modules use them in service commands, as in
# `ExecStart = lib.getExe pkgs.hello;`.
{ __, pkgs }:

let
  inherit (pkgs) lib;
in
{
  hello = {
    expr = lib.getExe pkgs.hello == "${pkgs.hello}/bin/hello";
    expected = /*>*/ true /*<*/;
  };

  script = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" (lib.getExe (pkgs.writeShellScriptBin "greet" "echo hi"));
    expected = /*>*/ [ "greet/bin/greet" ] /*<*/;
  };

  named = {
    expr = lib.getExe' pkgs.coreutils "ls" == "${pkgs.coreutils}/bin/ls";
    expected = /*>*/ true /*<*/;
  };
}
