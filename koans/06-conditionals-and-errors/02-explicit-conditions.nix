# Explicit conditions
#
# The condition of `if` must be a boolean. Nix has no "truthy" values, so
# `if [ ] then ...` is an error. Write the comparison explicitly instead.
{ __ }:

{
  emptyList = {
    expr = if [ ] == [ ] then "empty" else "full";
    expected = __;
  };

  emptyString = {
    expr = if "" != "" then "text" else "no text";
    expected = __;
  };

  presence = {
    expr = if { } ? a then 1 else 0;
    expected = __;
  };
}
