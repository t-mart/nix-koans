# Import nixpkgs
#
# The nixpkgs repository is a function. You call it with settings such as
# `system`, `config` and `overlays`, and it gives the package set. The runner
# gives this koan the package set for your machine as `pkgs`.
{ __, pkgs }:

{
  function = {
    expr = builtins.typeOf (import <nixpkgs>);
    expected = /*>*/ "lambda" /*<*/;
  };

  packageSet = {
    expr = builtins.typeOf pkgs;
    expected = /*>*/ "set" /*<*/;
  };

  hello = {
    expr = pkgs.hello.pname;
    expected = /*>*/ "hello" /*<*/;
  };

  otherSystem = {
    expr = (import <nixpkgs> { system = "aarch64-linux"; }).hello.system;
    expected = /*>*/ "aarch64-linux" /*<*/;
  };
}
