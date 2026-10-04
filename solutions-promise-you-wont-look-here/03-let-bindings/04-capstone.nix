# Capstone: let bindings
#
# This capstone combines `let`, binding order, shadowed names and `toString`.
# Package definitions in nixpkgs compute version strings in a similar way.
{ __ }:

{
  version = {
    expr =
      let
        version = "${toString major}.${toString minor}.${toString patch}";
        patch = minor + 1;
        minor = major * 2;
        major = 1;
      in
      version;
    expected = /*>*/ "1.2.3" /*<*/;
  };

  release = {
    expr =
      let
        name = "app";
        full =
          let
            name = "lib";
          in
          "${name}-${version}";
        version = "1.0";
      in
      "${name}: ${full}";
    expected = /*>*/ "app: lib-1.0" /*<*/;
  };
}
