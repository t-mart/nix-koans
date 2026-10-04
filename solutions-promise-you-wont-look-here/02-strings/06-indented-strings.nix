# Indented strings
#
# An "indented string" starts and ends with two single quotes. Nix removes the
# common indentation of its lines and the first line break. NixOS modules use
# indented strings for scripts and configuration files, as in
# `systemd.services.<name>.script`.
{ __ }:

{
  oneLine = {
    expr = ''hello'';
    expected = /*>*/ "hello" /*<*/;
  };

  stripIndentation = {
    expr = ''
      line one
        line two
    '';
    expected = /*>*/ "line one\n  line two\n" /*<*/;
  };

  noFinalNewline = {
    expr = ''
      a
      b'';
    expected = /*>*/ "a\nb" /*<*/;
  };
}
