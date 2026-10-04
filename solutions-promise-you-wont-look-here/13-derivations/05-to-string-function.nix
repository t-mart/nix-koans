# __toString
#
# A set with a `__toString` function also converts to a string. The function
# gets the set itself, like `__functor`. Library code uses it to give custom
# data a printable form.
{ __ }:

{
  custom = {
    expr = "${{ __toString = self: "custom"; }}";
    expected = /*>*/ "custom" /*<*/;
  };

  fromSelf = {
    expr = toString { __toString = self: "v${toString self.version}"; version = 2; };
    expected = /*>*/ "v2" /*<*/;
  };

  bothAttributes = {
    expr = "${{ __toString = self: "from toString"; outPath = "from outPath"; }}";
    expected = /*>*/ "from toString" /*<*/;
  };
}
