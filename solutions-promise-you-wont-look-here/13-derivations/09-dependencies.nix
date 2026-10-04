# Dependencies
#
# A derivation that uses the path of another derivation depends on it. A new
# version of the dependency gives the dependent derivation a new store path as
# well. This chain of hashes is why one library update makes Nix rebuild all
# packages that use the library.
{ __ }:

let
  mk = name: script: derivation { inherit name; system = "x86_64-linux"; builder = "/bin/sh"; args = [ "-c" script ]; };
  storeName = path: builtins.head (builtins.match "/nix/store/[a-z0-9]{32}-(.*)" path);
  lib1 = mk "lib" "echo v1 > $out";
  lib2 = mk "lib" "echo v2 > $out";
  app = dep: mk "app" "cat ${dep} > $out";
in
{
  sameDependency = {
    expr = (app lib1).outPath == (app lib1).outPath;
    expected = /*>*/ true /*<*/;
  };

  newDependency = {
    expr = (app lib1).outPath == (app lib2).outPath;
    expected = /*>*/ false /*<*/;
  };

  scriptContext = {
    expr = map storeName (builtins.attrNames (builtins.getContext (builtins.elemAt (app lib1).args 1)));
    expected = /*>*/ [ "lib.drv" ] /*<*/;
  };
}
