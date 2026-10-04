# nix-koans
Simple koans for learning nix. Inspired by [ruby koans](https://www.rubykoans.com).

New to nix? Start [here](nix_INTRO.md).

## Setup

The koans use the `nix` command. Upstream Nix marks this command as experimental.

On NixOS, add this to your system configuration:

```nix
nix.settings.experimental-features = [ "nix-command" ];
```

On other systems, add this line to `~/.config/nix/nix.conf`:

```
experimental-features = nix-command
```

If the setting already exists, add `nix-command` to its list.

Some later koans use nixpkgs, which they find as `<nixpkgs>` in the Nix search
path. To make sure that Nix can find it, run this command:

```
nix eval --impure --expr '<nixpkgs>'
```

If the command fails, set `NIX_PATH` before you run the koans:

```
export NIX_PATH=nixpkgs=channel:nixos-unstable
```

The koans only evaluate expressions. They do not build or install anything.
Some koans add small files to the Nix store. `nix-collect-garbage` removes them.

## Getting started

1. Run `nix eval --raw --file .` in this directory.
2. Open the file and line that the output shows.
3. Replace `__` with the value of `expr`. Do not copy the expression.
4. Do steps 1 to 3 again until all koans pass.

Some koans ask for code in place of a value. The comment at the top of the
file tells you what to write.

Each directory in `koans` is one section. [CURRICULUM.md](CURRICULUM.md) lists
the topics in order.

To experiment with an expression, use `nix repl`.

To start again, run `git restore koans`.
