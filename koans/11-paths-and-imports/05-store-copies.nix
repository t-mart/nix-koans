# Store copies
#
# Interpolation of a path copies the file into the "Nix store", a read-only
# directory, usually `/nix/store`. The name of a "store path" starts with a
# hash. This is how a build gets its source files. `toString` does not copy.
{ __ }:

{
  copied = {
    expr = builtins.match "/nix/store/[a-z0-9]{32}-(.*)" "${./fixtures/greeting.txt}";
    expected = __;
  };

  notCopied = {
    expr = builtins.match "/nix/store/.*" (toString ./fixtures/greeting.txt);
    expected = __;
  };

  different = {
    expr = toString ./fixtures/greeting.txt == "${./fixtures/greeting.txt}";
    expected = __;
  };
}
