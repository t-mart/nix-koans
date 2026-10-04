# Resolution
#
# Nix resolves a relative path against the directory of the file that
# contains it, not against the current directory of your shell. `toString`
# shows the absolute path as a string.
{ __ }:

{
  absolute = {
    expr = builtins.substring 0 1 (toString ./.);
    expected = __;
  };

  thisDirectory = {
    expr = builtins.match ".*/koans/(.*)" (toString ./.);
    expected = __;
  };

  file = {
    expr = builtins.match ".*/koans/(.*)" (toString ./fixtures/greeting.txt);
    expected = __;
  };
}
