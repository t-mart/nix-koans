# override
#
# `.override` calls a package function again with changed arguments.
# `lib.makeOverridable` adds it, and `callPackage` uses that function. Users
# call it to change a dependency or a feature flag, as in
# `pkgs.foo.override { withGui = false; }`.
#
# Replace __ with a function `makeOverridable`. It takes a function `f` and
# its arguments `args`. It gives `f args` plus an attribute `override`.
# `override` takes new arguments, merges them into `args` and calls `f`
# again. The result must also have `override`.
{ __ }:

let
  makeOverridable = __;
  greeter = { greeting, name }: { message = "${greeting}, ${name}!"; };
  hello = makeOverridable greeter { greeting = "Hello"; name = "world"; };
in
{
  original = {
    expr = hello.message;
    expected = "Hello, world!";
  };

  overridden = {
    expr = (hello.override { name = "Nix"; }).message;
    expected = "Hello, Nix!";
  };

  twice = {
    expr = ((hello.override { name = "Nix"; }).override { greeting = "Hi"; }).message;
    expected = "Hi, Nix!";
  };
}
