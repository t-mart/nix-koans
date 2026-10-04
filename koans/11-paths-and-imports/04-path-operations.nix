# Path operations
#
# `baseNameOf` and `dirOf` split a path, like the shell commands `basename`
# and `dirname`. A path plus a string gives a new path.
# `builtins.pathExists` checks if a file exists.
{ __ }:

{
  baseName = {
    expr = baseNameOf ./fixtures/greeting.txt;
    expected = __;
  };

  directory = {
    expr = baseNameOf (dirOf ./fixtures/greeting.txt);
    expected = __;
  };

  exists = {
    expr = builtins.pathExists ./fixtures/greeting.txt;
    expected = __;
  };

  absent = {
    expr = builtins.pathExists ./fixtures/absent.txt;
    expected = __;
  };

  append = {
    expr = builtins.typeOf (./fixtures + "/greeting.txt");
    expected = __;
  };
}
