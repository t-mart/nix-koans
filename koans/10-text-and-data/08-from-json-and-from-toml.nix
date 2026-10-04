# fromJSON and fromTOML
#
# `builtins.fromJSON` and `builtins.fromTOML` read text into Nix values. Nix
# code uses them to read lock files and settings from other tools, such as
# `package.json` or `Cargo.toml`.
{ __ }:

{
  json = {
    expr = builtins.fromJSON ''{"port": 80, "hosts": ["a"]}'';
    expected = __;
  };

  jsonList = {
    expr = builtins.fromJSON "[1, 2.5, null]";
    expected = __;
  };

  toml = {
    expr = builtins.fromTOML ''
      [server]
      port = 8080
    '';
    expected = __;
  };
}
