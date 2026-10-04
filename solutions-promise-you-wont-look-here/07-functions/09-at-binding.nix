# The @ binding
#
# `args@{ ... }:` binds the whole argument set to `args` as well. The set
# holds only the attributes that the caller passed. Defaults are not part of
# it, which surprises many Nix users.
{ __ }:

{
  wholeSet = {
    expr = (args@{ a, ... }: args) { a = 1; b = 2; };
    expected = /*>*/ { a = 1; b = 2; } /*<*/;
  };

  noDefaults = {
    expr = (args@{ a ? 1, ... }: args) { };
    expected = /*>*/ { } /*<*/;
  };

  otherSide = {
    expr = ({ a ? 1, ... }@args: args ? a) { };
    expected = /*>*/ false /*<*/;
  };

  nameStillWorks = {
    expr = (args@{ a ? 1, ... }: a) { };
    expected = /*>*/ 1 /*<*/;
  };
}
