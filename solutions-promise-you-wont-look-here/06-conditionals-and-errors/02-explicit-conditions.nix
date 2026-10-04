# Explicit conditions
#
# The condition of `if` must be a boolean. Nix has no "truthy" values, so
# `if [ ] then ...` is an error. Write the comparison explicitly instead.
{ __ }:

{
  emptyList = {
    expr = if [ ] == [ ] then "empty" else "full";
    expected = /*>*/ "empty" /*<*/;
  };

  emptyString = {
    expr = if "" != "" then "text" else "no text";
    expected = /*>*/ "no text" /*<*/;
  };

  presence = {
    expr = if { } ? a then 1 else 0;
    expected = /*>*/ 0 /*<*/;
  };
}
