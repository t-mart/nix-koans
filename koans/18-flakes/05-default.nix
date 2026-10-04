# default
#
# `nix build` without a name builds `packages.<system>.default`. `nix run` and
# `nix develop` look for `apps.<system>.default` and
# `devShells.<system>.default` in the same way. For `nix build .#name`, Nix
# looks in `packages` first and then in `legacyPackages`.
#
# Replace the first __ with a function `resolve`. It takes a system and a name
# and gives the package that `nix build` picks. Then predict the dev shell.
{ __ }:

let
  outputs = {
    packages.x86_64-linux = {
      default = "tool";
      docs = "tool-docs";
    };
    legacyPackages.x86_64-linux.cowsay = "cowsay";
    devShells.x86_64-linux.default = "tool-shell";
  };
  resolve = __;
in
{
  noName = {
    expr = resolve "x86_64-linux" "default";
    expected = "tool";
  };

  named = {
    expr = resolve "x86_64-linux" "docs";
    expected = "tool-docs";
  };

  legacy = {
    expr = resolve "x86_64-linux" "cowsay";
    expected = "cowsay";
  };

  develop = {
    expr = outputs.devShells.x86_64-linux.default;
    expected = __;
  };
}
