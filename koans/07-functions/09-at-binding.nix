# The @ binding
#
# `args@{ ... }:` binds the whole argument set to `args` as well. The set
# holds only the attributes that the caller passed. Defaults are not part of
# it, which surprises many Nix users.
{ __ }:

{
  wholeSet = {
    expr = (args@{ a, ... }: args) { a = 1; b = 2; };
    expected = __;
  };

  noDefaults = {
    expr = (args@{ a ? 1, ... }: args) { };
    expected = __;
  };

  otherSide = {
    expr = ({ a ? 1, ... }@args: args ? a) { };
    expected = __;
  };

  nameStillWorks = {
    expr = (args@{ a ? 1, ... }: a) { };
    expected = __;
  };
}
