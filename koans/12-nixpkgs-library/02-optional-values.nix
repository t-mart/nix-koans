# Optional values
#
# These functions give a value when a condition is true, and an empty value
# otherwise. Package and module code uses them for optional features, as in
# `buildInputs = lib.optional withGui gtk3;`.
{ __, lib }:

{
  optional = {
    expr = lib.optional true "a";
    expected = __;
  };

  optionalFalse = {
    expr = [ "base" ] ++ lib.optional false "gui";
    expected = __;
  };

  optionals = {
    expr = lib.optionals true [ "a" "b" ];
    expected = __;
  };

  optionalString = {
    expr = "run" + lib.optionalString false " --verbose";
    expected = __;
  };

  optionalAttrs = {
    expr = { a = 1; } // lib.optionalAttrs true { b = 2; };
    expected = __;
  };
}
