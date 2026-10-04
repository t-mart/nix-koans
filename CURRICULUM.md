# Curriculum

The koans teach Nix in the order below. Each section maps to one directory in
`koans`, for example `01-basics`. Each numbered item maps to one koan file, for
example `01-basics/01-booleans.nix`.

The koans are cumulative. A koan uses concepts from earlier items only. The last
item of each section is a capstone that combines its section with earlier
sections. A reference such as "(uses 2.4)" identifies an earlier item that the
koan builds on.

## Constraints

- The runner compares `expr == expected`. Functions do not compare equal, so an
  expected value must be data.
- `builtins.tryEval` catches only `throw` and `assert`. Other errors stop the
  runner. For those topics, test a safe form such as `s ? a`.
- Koans do not build anything. A derivation koan inspects attributes such as
  `name` and `outPath`.
- Sections 12, 17 and 18 and item 14.9 need the nixpkgs `lib`. Section 16 needs
  the full nixpkgs. The runner passes `lib` and `pkgs` from `<nixpkgs>` to a
  koan file that names them in its argument pattern.

## 1. Basics

- **1.1 Booleans**: `true` and `false` are values.
- **1.2 Integers**: `+`, `-` and `*` operate on integers.
- **1.3 Integer division**: `/` on two integers discards the remainder. `7 / 2`
  is `3`.
- **1.4 Floats**: an operation with a float gives a float. `7.0 / 2` is `3.5`.
- **1.5 Comparison**: `==`, `!=`, `<` and `>=` compare values. An integer and a
  float with the same value are equal.
- **1.6 Logic**: `&&`, `||`, `!` and the implication operator `->`.
- **1.7 Null and types**: `null` is a value. `builtins.typeOf` gives the type
  name of a value.
- **1.8 Capstone**: predict the type and value of an expression with integers,
  floats and logic. (uses 1.3 to 1.7)

## 2. Strings

- **2.1 Concatenation**: `+` joins two strings.
- **2.2 Interpolation**: `"${x}"` inserts the string `x` into a string.
- **2.3 toString**: interpolation does not accept an integer. `toString`
  converts it to a string. (uses 1.2)
- **2.4 toString surprises**: `toString` gives `"1"` for `true`, `""` for
  `false` and `null`, and `"1.500000"` for `1.5`. (uses 1.1, 1.4, 1.7)
- **2.5 Escapes**: `\n`, `\"` and `\${` in double-quoted strings.
- **2.6 Indented strings**: `''...''` removes the common indentation and the
  first line break.
- **2.7 Escapes in indented strings**: `''${` gives a literal `${`. `'''` gives
  `''`.
- **2.8 Capstone**: write a multi-line shell script that contains numbers and
  booleans. (uses 2.2 to 2.7)

## 3. Let bindings

- **3.1 let**: `let x = 1; in x` gives a name to a value for one expression.
- **3.2 Order**: bindings in one `let` can refer to each other in any order.
- **3.3 Shadowed names**: an inner `let` hides a name from an outer `let`.
- **3.4 Capstone**: make a version string from integer parts in a `let`. (uses
  2.3, 3.2)

## 4. Lists

- **4.1 Literals**: spaces separate list elements. Lists have no commas.
- **4.2 Mixed types**: one list can hold values of different types. (uses 1.7)
- **4.3 Concatenation**: `++` joins two lists.
- **4.4 Access**: `builtins.length`, `builtins.head`, `builtins.tail` and
  `builtins.elemAt`.
- **4.5 Membership**: `builtins.elem x xs` is `true` when `xs` contains `x`.
- **4.6 Equality**: two lists are equal when all of their elements are equal, in
  the same order.
- **4.7 Capstone**: get the last element of a list from a `let` binding. (uses
  3.1, 4.4)

## 5. Attribute sets

- **5.1 Selection**: `{ a = 1; }.a` selects an attribute.
- **5.2 Nested keys**: `a.b = 1;` makes a nested set. Two nested keys with the
  same prefix merge into one set.
- **5.3 Presence**: `s ? a` and `s ? a.b` are `true` when the attribute exists.
  (uses 5.2)
- **5.4 Defaults**: `s.a or d` gives `d` when `s` has no attribute `a`.
- **5.5 Update**: `//` combines two sets. For a name in both sets, the right
  value wins.
- **5.6 Shallow update**: `//` replaces a nested set as a whole. It does not
  merge the two nested sets. (uses 5.2, 5.5)
- **5.7 rec**: in a `rec` set, the attributes can refer to each other. (uses
  3.2)
- **5.8 inherit**: `inherit x;` means `x = x;`. `inherit (s) x;` means
  `x = s.x;`. (uses 3.1)
- **5.9 Dynamic names**: `{ ${n} = 1; }`, `s.${n}` and `s."a b"`. (uses 2.2)
- **5.10 Sorted names**: `builtins.attrNames` and `builtins.attrValues` follow
  the sorted order of names, not the source order. (uses 4.6)
- **5.11 Removal**: `builtins.removeAttrs s [ "a" ]` gives `s` without `a`.
  (uses 4.1)
- **5.12 with**: `with s; e` puts the attributes of `s` in scope for `e`.
- **5.13 with and let**: a `let` binding hides an attribute of a `with`, also
  when the `with` is the inner expression. (uses 3.3, 5.12)
- **5.14 Capstone**: merge user settings into default settings, then list the
  names of the result. (uses 3.2, 5.6, 5.8, 5.10)

## 6. Conditionals and errors

- **6.1 if**: `if c then a else b` is an expression with a value. The `else`
  part is mandatory.
- **6.2 Explicit conditions**: the condition must be a bool. Nix has no truthy
  values, so compare explicitly, for example `xs == [ ]`. (uses 4.6)
- **6.3 else if**: a chain of conditions gives the first branch with a true
  condition.
- **6.4 throw**: `throw "message"` stops evaluation with an error.
- **6.5 tryEval**: `builtins.tryEval e` gives `{ success; value; }`. After a
  `throw`, `success` and `value` are both `false`. (uses 6.4)
- **6.6 assert**: `assert c; e` gives `e` when `c` is true. Otherwise it fails
  like `throw`. (uses 6.5)
- **6.7 trace**: `builtins.trace msg e` prints `msg` and gives `e`. Use it to
  inspect values.
- **6.8 Capstone**: validate a port number with `assert` and `if`, and catch the
  failure with `tryEval`. (uses 1.5, 3.1, 6.3, 6.6)

## 7. Functions

- **7.1 Lambdas**: `x: x + 1` is a function. A space applies it, as in `f 1`.
- **7.2 Currying**: `a: b: a + b` takes two arguments, one at a time. `add 1`
  gives a new function.
- **7.3 Precedence**: application binds tighter than operators. `f 1 * 2` means
  `(f 1) * 2`. (uses 1.2)
- **7.4 Application in lists**: `[ f 1 ]` has two elements. `[ (f 1) ]` has one.
  (uses 4.1, 4.4)
- **7.5 Closures**: a function keeps the bindings of the scope that defines it.
  (uses 3.3)
- **7.6 Set patterns**: `{ a, b }: a + b` takes a set and binds its attributes.
  (uses 5.1)
- **7.7 Extra attributes**: `...` lets a pattern accept attributes that it does
  not name. Without `...`, an extra attribute is an error.
- **7.8 Defaults**: `{ a ? 1 }:` gives `a` a value when the caller does not
  supply it.
- **7.9 The @ binding**: `args@{ a, ... }:` binds the whole argument set to
  `args`. Defaults do not appear in `args`. (uses 7.7, 7.8)
- **7.10 functionArgs**: `builtins.functionArgs` gives the names of a pattern.
  The value is `true` for a name with a default. (uses 7.8)
- **7.11 Recursion**: a function in a `let` can call itself. (uses 3.2, 6.1)
- **7.12 Function equality**: a function is never equal to another value, not
  even to itself. (uses 1.5)
- **7.13 Functors**: a set with a `__functor` attribute works as a function.
  (uses 5.1)
- **7.14 Capstone**: write `range { from ? 0, to }`, which gives a list of
  integers. (uses 4.3, 6.1, 7.8, 7.11)

## 8. Laziness

- **8.1 Unused bindings**: Nix does not evaluate a binding that the result does
  not use. (uses 3.1, 6.4)
- **8.2 Attributes**: a selection evaluates only the selected attribute. (uses
  5.1)
- **8.3 List elements**: `builtins.length` does not evaluate the elements. (uses
  4.4)
- **8.4 Arguments**: Nix does not evaluate an argument that the function
  ignores. (uses 7.1)
- **8.5 Short circuit**: `false && e` and `false -> e` do not evaluate `e`.
  (uses 1.6)
- **8.6 Shallow evaluation**: `builtins.seq` and `tryEval` evaluate only the
  outer layer of a value. `builtins.deepSeq` evaluates all of it. (uses 6.5)
- **8.7 Self-reference**: a set can refer to itself through its `let` name.
  (uses 3.2, 5.7)
- **8.8 Infinite structures**: a function can describe an infinite stream of
  sets. Nix evaluates only the part that you select. (uses 7.11)
- **8.9 Capstone**: select one package from a package set that contains a broken
  package. nixpkgs depends on this behavior. (uses 5.4, 6.5, 8.2, 8.7)

## 9. Higher-order functions

- **9.1 map**: `map f xs` applies `f` to each element. (uses 7.2)
- **9.2 filter**: `builtins.filter p xs` keeps the elements for which `p` is
  true.
- **9.3 foldl'**: `builtins.foldl' f init xs` reduces a list from the left.
- **9.4 concatMap**: `builtins.concatMap` maps and then joins the lists. (uses
  4.3)
- **9.5 genList**: `builtins.genList f n` makes a list from indices. Compare it
  with capstone 7.14.
- **9.6 sort**: `builtins.sort` takes a "less than" function. (uses 1.5)
- **9.7 mapAttrs**: `builtins.mapAttrs` gives the function both the name and the
  value. (uses 7.2)
- **9.8 listToAttrs**: `builtins.listToAttrs` makes a set from a list of
  `{ name; value; }` sets. For a duplicate name, the first entry wins. (uses
  5.5)
- **9.9 catAttrs**: `builtins.catAttrs` collects one attribute from a list of
  sets. (uses 5.3)
- **9.10 partition**: `builtins.partition` splits a list into `right` and
  `wrong`.
- **9.11 intersectAttrs**: `builtins.intersectAttrs a b` keeps the attributes of
  `b` whose names are in `a`.
- **9.12 pipe**: write `pipe`, which applies a list of functions in order, with
  `foldl'`. (uses 9.3)
- **9.13 Capstone**: turn a list of package records into a set by name, with
  only the enabled packages. (uses 5.9, 9.1, 9.2, 9.8)

## 10. Text and data

- **10.1 Substrings**: `builtins.stringLength` and `builtins.substring`.
- **10.2 Replace**: `builtins.replaceStrings` takes a list of patterns and a
  list of replacements. (uses 4.1)
- **10.3 Join**: `builtins.concatStringsSep` joins a list of strings with a
  separator. (uses 9.1)
- **10.4 match**: `builtins.match` matches the whole string. It gives `null`, or
  a list of the captured groups. (uses 1.7)
- **10.5 split**: `builtins.split` gives a list. Strings alternate with lists of
  captured groups. (uses 10.4)
- **10.6 Versions**: `builtins.parseDrvName` splits `"hello-2.12.1"` into a name
  and a version. `builtins.compareVersions` orders versions, so `"1.10"` is
  greater than `"1.9"`.
- **10.7 toJSON**: `builtins.toJSON` gives JSON text. The keys are in sorted
  order. (uses 5.10)
- **10.8 fromJSON and fromTOML**: `builtins.fromJSON` and `builtins.fromTOML`
  convert text to Nix values. (uses 2.6)
- **10.9 Capstone**: parse `key=value` lines into a set, then convert the set to
  JSON. (uses 2.6, 9.2, 9.8, 10.4, 10.5, 10.7)

## 11. Paths and imports

- **11.1 Path type**: `./.` is a path, not a string. (uses 1.7)
- **11.2 Division or path**: `7/2` without spaces is a path, not a division.
  (uses 1.3, 11.1)
- **11.3 Resolution**: Nix resolves a relative path against the directory of its
  file. `toString` shows the absolute path. (uses 2.3)
- **11.4 Path operations**: `baseNameOf`, `dirOf`, `builtins.pathExists` and
  `./. + "/name"`.
- **11.5 Store copies**: interpolation of a path copies the file to the Nix
  store. `toString` does not copy. (uses 2.2, 10.1)
- **11.6 Read files**: `builtins.readFile` gives the text of a file.
  `builtins.readDir` gives the entries of a directory.
- **11.7 import**: `import ./file.nix` evaluates the file and gives its value.
- **11.8 Koan files**: each koan file is a function. The runner calls it with a
  set that contains `__`. This explains the first line of each koan file. (uses
  7.6, 11.7)
- **11.9 Lookup paths**: `<name>` means
  `builtins.findFile builtins.nixPath "name"`. The result depends on
  `NIX_PATH`. (uses 5.1, 11.4)
- **11.10 Capstone**: import all `.nix` files of a directory into one set. (uses
  9.2, 9.8, 10.4, 11.6, 11.7)

## 12. The nixpkgs library

- **12.1 lib is Nix code**: `lib` is a set of functions in nixpkgs. It is not
  part of the language. It also provides many of the builtins.
- **12.2 Optional values**: `lib.optional`, `lib.optionals`,
  `lib.optionalString` and `lib.optionalAttrs`. (uses 6.1)
- **12.3 Deep merge**: `lib.recursiveUpdate` merges nested sets. Compare it with
  `//`. (uses 5.6)
- **12.4 Attribute helpers**: `lib.mapAttrsToList`, `lib.filterAttrs` and
  `lib.genAttrs`. (uses 9.7)
- **12.5 Renames**: `lib.mapAttrs'` with `lib.nameValuePair` changes names and
  values. (uses 9.8)
- **12.6 Attribute paths**: `lib.attrByPath` and `lib.setAttrByPath` work with a
  list of names. (uses 5.2, 5.4)
- **12.7 String helpers**: `lib.hasPrefix`, `lib.removePrefix`,
  `lib.splitString` and `lib.concatMapStringsSep`. (uses 10.3)
- **12.8 Capstone**: write capstone 9.13 again with `lib.pipe` and the helpers of
  this section. (uses 9.12, 9.13, 12.4)

## 13. Derivations

- **13.1 derivation**: `derivation { name; system; builder; }` gives a set with
  `type = "derivation"`. (uses 1.7, 5.1)
- **13.2 Evaluation does not build**: `outPath` and `drvPath` are known before a
  build.
- **13.3 Input hashes**: equal inputs give an equal `outPath`. A change to any
  input gives a different `outPath`. (uses 13.2)
- **13.4 String coercion**: a set with an `outPath` converts to that string.
  Interpolation of a derivation gives its store path. (uses 2.2)
- **13.5 __toString**: a set with a `__toString` function also converts to a
  string. (uses 7.13)
- **13.6 String context**: a string made from a derivation carries the
  dependency. `builtins.getContext` shows it. (uses 13.4)
- **13.7 Context propagation**: the result of a string function keeps the
  context of its input. (uses 10.1, 13.6)
- **13.8 Discard context**: `builtins.unsafeDiscardStringContext` removes the
  context. Nix then does not know about the dependency. (uses 13.6)
- **13.9 Dependencies**: a derivation that interpolates another derivation
  changes when that dependency changes. (uses 13.3, 13.4)
- **13.10 Multiple outputs**: `outputs = [ "out" "dev" ];` gives `drv.dev` with
  its own `outPath`.
- **13.11 Fixed-output derivations**: with `outputHash`, `outPath` depends only
  on the name and the hash. The URL has no effect. (uses 13.3)
- **13.12 Capstone**: write `mkPackage { pname, version, ... }`, which makes a
  derivation named `pname-version`. (uses 2.2, 5.11, 7.9, 13.1)

## 14. Fixed points and overlays

- **14.1 rec is closed**: `rec { a = 1; b = a + 1; } // { a = 10; }` keeps
  `b = 2`. (uses 5.5, 5.7)
- **14.2 fix**: write `fix = f: let x = f x; in x;` and use it to make a set
  that refers to itself. (uses 7.11, 8.7)
- **14.3 Late binding**: with `fix`, an update of `a` inside the function also
  updates `b`. (uses 14.1, 14.2)
- **14.4 Overlays**: an overlay is a function `final: prev: { ... }`. `prev` is
  the set before the overlay. `final` is the result after all overlays. (uses
  7.2)
- **14.5 extends**: write `extends`, which applies an overlay to a function of
  `final`. (uses 5.5, 14.2, 14.4)
- **14.6 final or prev**: use `prev.x` to change `x` in terms of its old value.
  `final.x` in the definition of `x` gives infinite recursion. (uses 14.5)
- **14.7 Overlay order**: the result of two overlays depends on their order.
  (uses 14.5)
- **14.8 Strict names**: the attribute names of an overlay result must not
  depend on `final`. Otherwise, Nix reports infinite recursion. (uses 8.6,
  14.6)
- **14.9 lib versions**: `lib.fix`, `lib.extends` and
  `lib.composeManyExtensions`. (uses 14.2, 14.5, 14.7)
- **14.10 Capstone**: make a small package set with `fix` and two overlays. One
  overlay changes a dependency. A package that uses the dependency sees the
  change. (uses 13.9, 13.12, 14.5, 14.7)

## 15. Package patterns

- **15.1 callPackage**: `callPackage` supplies function arguments from a package
  set. Write it with `functionArgs` and `intersectAttrs`. (uses 7.10, 9.11)
- **15.2 Explicit arguments**: the second argument of `callPackage` wins over
  the package set. (uses 5.5)
- **15.3 Defaults**: an argument that is not in the package set keeps its
  default. (uses 7.8)
- **15.4 override**: `makeOverridable` adds `.override`, which calls the
  function again with changed arguments. Write it. (uses 5.5, 7.9)
- **15.5 overrideAttrs**: `overrideAttrs` changes the attributes of the
  derivation, not the arguments of the function. Add it to `mkPackage`. (uses
  13.12, 14.4)
- **15.6 override or overrideAttrs**: for each change in a list, select the
  correct function. (uses 15.4, 15.5)
- **15.7 finalAttrs**: `mkPackage (finalAttrs: { ... })` lets attributes refer
  to their final values, after overrides. (uses 14.3, 15.5)
- **15.8 Capstone**: make a package set with `fix` and `callPackage`. Add an
  overlay that overrides one package, and check a package that depends on it.
  (uses 14.10, 15.1, 15.4)

## 16. nixpkgs in practice

- **16.1 Import nixpkgs**: nixpkgs is a function.
  `import nixpkgs { system = "x86_64-linux"; }` gives the package set. (uses
  7.6, 11.7)
- **16.2 mkDerivation**: `stdenv.mkDerivation` makes `name` from `pname` and
  `version`. Compare it with `mkPackage`. (uses 13.12)
- **16.3 Build inputs**: `nativeBuildInputs` hold tools that run during the
  build. `buildInputs` hold libraries for the result.
- **16.4 meta and passthru**: `meta` holds data such as the license.
  `passthru` adds attributes that do not change `outPath`. (uses 13.3)
- **16.5 Real overrides**: `override` and `overrideAttrs` on a nixpkgs package
  change its `outPath`. (uses 13.3, 15.6)
- **16.6 Trivial builders**: `writeShellScriptBin` and `writeText` make
  derivations from strings. (uses 2.6)
- **16.7 Fetchers**: `fetchurl` makes a fixed-output derivation. (uses 13.11)
- **16.8 getExe**: `lib.getExe` gives the path of the main program of a package.
  (uses 13.4)
- **16.9 Capstone**: add a package to nixpkgs with an overlay and
  `callPackage`. The package uses a script from a trivial builder. (uses 15.8,
  16.1, 16.6)

## 17. The module system

- **17.1 Module shape**: a module is a set with `imports`, `options` and
  `config`, or a function that gives that set. (uses 7.6)
- **17.2 evalModules**: `lib.evalModules { modules = [ ... ]; }` gives the
  merged `config`.
- **17.3 Options**: `lib.mkOption` declares an option with a `type` and a
  `default`.
- **17.4 Types**: the type checks the value. A value of the wrong type is an
  error. (uses 6.5)
- **17.5 Merge rules**: lists from many modules concatenate. Sets merge. Two
  different integers conflict. (uses 4.3, 5.5)
- **17.6 Priorities**: `lib.mkDefault` loses to a plain value. `lib.mkForce`
  wins over a plain value.
- **17.7 List order**: `lib.mkBefore` and `lib.mkAfter` control the order of
  merged lists. (uses 17.5)
- **17.8 The config argument**: a module function gets the final `config`. A
  module reads other options through it. (uses 14.2)
- **17.9 mkIf**: `lib.mkIf` makes a definition depend on `config` without
  infinite recursion. An `if` around the whole `config` set does not. (uses
  14.8, 17.8)
- **17.10 mkMerge**: `lib.mkMerge` combines several definitions in one module.
- **17.11 imports**: `imports` adds other modules, often from other files.
  (uses 11.7)
- **17.12 Submodules**: `types.attrsOf (types.submodule ...)` declares a set of
  structured values.
- **17.13 Capstone**: write a service module with an `enable` option. When
  `enable` is true, the module adds an entry to a list option. A second module
  changes a default of the first. (uses 17.5, 17.6, 17.8, 17.9)

## 18. Flakes

The koans call the `outputs` function of a flake directly, with mock inputs.

- **18.1 Flake shape**: `flake.nix` holds a set with `description`, `inputs` and
  `outputs`. (uses 5.1)
- **18.2 outputs**: `outputs` is a function. It takes the inputs as a set. (uses
  7.6, 7.7)
- **18.3 self**: `self` is the result of `outputs`. An output refers to another
  output through `self`. (uses 14.2)
- **18.4 Per-system outputs**: packages live under `packages.<system>.<name>`.
  A flake names each system explicitly. `lib.genAttrs` makes the set for a list
  of systems. (uses 12.4)
- **18.5 default**: `packages.<system>.default` is the package that `nix build`
  selects when you give no name.
- **18.6 Other outputs**: `devShells` and `checks` have the same shape as
  `packages`. `overlays` holds overlays and `nixosModules` holds modules. (uses
  14.4, 17.1)
- **18.7 Overlay output**: a flake applies its own overlay to its nixpkgs input.
  (uses 14.10, 18.3)
- **18.8 Capstone**: write `outputs` for a flake with a package for two systems,
  an overlay and a dev shell. Evaluate it with mock inputs. (uses 15.8, 18.3 to
  18.7)

## 19. The koan runner

These koans read `default.nix`, the program that checks the koans.

- **19.1 Find the koans**: `readDir`, `filter` and `match` select the koan
  files. (uses 9.2, 10.4, 11.6)
- **19.2 Arguments**: the runner calls each koan file with only the arguments
  that it names, like `callPackage`. (uses 11.8, 15.1)
- **19.3 Positions**: `builtins.unsafeGetAttrPos` gives the file and line of an
  attribute.
- **19.4 Order**: the runner sorts the koans of a file by line. (uses 9.6, 19.3)
- **19.5 Safe comparison**: `tryEval` turns the `throw` of `__` into a failed
  koan. (uses 6.5, 11.8)
- **19.6 First failure**: a recursive function finds the first koan that fails.
  Short circuit stops the search at the end of the list. (uses 7.11, 8.5)
- **19.7 Capstone**: write a function that gives the names of all failed koans,
  not only the first. (uses 19.1 to 19.6)
