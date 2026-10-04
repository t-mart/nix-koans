can you introduce me to the nix language?

im trying to understand more about the syntax.

while learning, i don't want to adversely affect my system. is there a way to
just treat nix as a program that doesn't make changes like this?

and, should we start by making a package or flake?

im familiar with javascript and python, for reference Covering syntax basics and
how to start practicing.

Nix (the language) is pure and lazy, so evaluating expressions can't change your
system. Nix the language is a small functional expression language, closer to
JSON with functions than to Python. Evaluating it computes a value and nothing
else. Your system only changes when you run commands built to do that. Safe vs.
state-changing Safe to play with Actually changes your environment nix repl, nix
eval, nix-instantiate --eval nix profile install, nix-env -i nix build (writes
to /nix/store plus a ./result symlink) nixos-rebuild switch, home-manager switch
nix shell nixpkgs#foo, nix develop (temporary shells) darwin-rebuild switch

Even nix build only adds immutable paths to /nix/store. Nothing gets put on your
PATH, and nix-collect-garbage cleans it up. If you avoid the right-hand column,
you're fine.

The REPL is the best playground: nu

nix repl

Inside it, :q quits, :p expr prints deeply, and :l <nixpkgs> loads the package
set so you can poke at it. If you get an "experimental feature" error, use this
instead: nu

nix --extra-experimental-features 'nix-command flakes' repl

For a file-based workflow, nushell's single-quoted strings pass " through
untouched. JSON output also pipes nicely into nushell: nu

nix eval --expr '{ a = 1; b = "hi"; }.b' nix eval --json --file learn.nix | from
json

The syntax, mapped to JS/Python

Save this as learn.nix and evaluate it: nix

let

# let ... in ≈ a block of consts, then one expression that uses them

name = "world"; n = 41;

# Attribute set ≈ JS object / Python dict. Note `=` and mandatory `;`

person = { first = "Ada"; age = 36; nested.deep = true; }; # dotted keys create
nesting

# Lists are SPACE-separated, no commas

nums = [ 1 2 3 ];

# Gotcha: [ f x ] is a 2-element list; write [ (f x) ] to call f

# Functions: one argument, `arg: body` ≈ (arg) => body

inc = x: x + 1;

# Multiple args = currying ≈ a => b => a + b

add = a: b: a + b;

# Destructuring an attrset, with a default ≈ ({a, b = 2}) => a + b

# `...` allows extra keys (otherwise passing extras is an error)

addAttrs = { a, b ? 2, ... }: a + b; in {

# Calling is by juxtaposition: f x, not f(x)

greeting = "hello ${name}";                # string interpolation, like `${}` in
JS answer = inc n; # 42 sum = add 1 2; # 3 partial = (add 10) 5; # 15, partial
application for free fromAttrs = addAttrs { a = 1; }; # 3

# if is an expression (like Python's x if c else y); else is required

parity = if n / 2 \* 2 == n then "even" else "odd";

# `//` merges attrsets, right side wins ≈ { ...person, age: 37 }

older = person // { age = 37; };

# `inherit x;` is shorthand for `x = x;` ≈ JS { name }

inherit name;

# `?` tests for a key; `or` supplies a default for a missing key

hasAge = person ? age; # true city = person.city or "unknown";

# builtins is the standard library

doubled = map (x: x \* 2) nums; # [ 2 4 6 ] keys = builtins.attrNames person;

# Multi-line strings use '' and strip common indentation (great for scripts)

script = '' echo "hi" echo ${name} ''; }

A few more things you'll see everywhere:

    Laziness: values are only computed when needed. { a = 1; b = throw "boom"; }.a returns 1 without error. This is why nixpkgs, an enormous attrset, is usable at all.
    with pkgs; brings an attrset's keys into scope, so [ git curl ] means [ pkgs.git pkgs.curl ]. It's convenient but makes it unclear where names come from.
    rec { ... } lets keys in a set refer to each other. Most people prefer let instead.
    Paths are their own type: ./foo.nix is not a string. import ./foo.nix evaluates that file and returns its value, which is often a function you then call. That's how nearly all Nix files are structured: { pkgs, ... }: { ... }.

Package or flake first?

They aren't alternatives: a flake contains packages. A package (a derivation) is
a recipe for building something. A flake is a file that declares inputs (like
nixpkgs) and exposes outputs (packages, dev shells, and so on).

I'd go in this order:

    The language in the REPL. Get comfortable with attrsets, functions, and let. This is most of the learning.
    A tiny package, e.g. pkgs.writeShellScriptBin "hello-me" "echo hi", then a real stdenv.mkDerivation. This teaches what a derivation is, and you build it with nix build, which is safe.
    Wrap it in a flake. A flake.nix is just an attrset whose outputs is a function taking your inputs. Once you understand steps 1 and 2, it reads as ordinary Nix, not magic.

Starting with a flake means copying boilerplate you can't read yet, which is
where most people get stuck.

Want to do step 2 next? I can walk you through a minimal package and then turn
it into a flake with a dev shell. nix.dev's language tutorial is also a good
companion for exercises.
