# trace
#
# `builtins.trace msg e` prints `msg` and gives `e`. Use it to inspect values
# in the middle of evaluation. After you solve this koan, look for the
# "trace:" line in the output of the runner.
{ __ }:

{
  trace = {
    expr = builtins.trace "Hello from the trace koan" (6 * 7);
    expected = __;
  };
}
