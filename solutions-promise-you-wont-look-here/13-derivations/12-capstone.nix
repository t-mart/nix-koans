# Capstone: derivations
#
# This capstone combines set patterns, the `@` binding, `//` and
# `derivation`. You write a small version of `stdenv.mkDerivation` from
# nixpkgs. Later koans build on it.
#
# Replace __ with a function `mkPackage`. It takes a set with `pname`,
# `version` and any other attributes. It gives a derivation with the name
# "pname-version", system "x86_64-linux" and builder "/bin/sh". It passes the
# other attributes to `derivation` too.
{ __ }:

let
  mkPackage = /*>*/ args@{ pname, version, ... }: derivation ({ system = "x86_64-linux"; builder = "/bin/sh"; } // args // { name = "${pname}-${version}"; }) /*<*/;
  hello = mkPackage {
    pname = "hello";
    version = "2.12";
    args = [ "-c" "echo hello > $out" ];
  };
  storeName = path: builtins.head (builtins.match "/nix/store/[a-z0-9]{32}-(.*)" path);
in
{
  name = {
    expr = hello.name;
    expected = "hello-2.12";
  };

  storePath = {
    expr = storeName hello.outPath;
    expected = "hello-2.12";
  };

  args = {
    expr = hello.args;
    expected = [ "-c" "echo hello > $out" ];
  };

  type = {
    expr = hello.type;
    expected = "derivation";
  };
}
