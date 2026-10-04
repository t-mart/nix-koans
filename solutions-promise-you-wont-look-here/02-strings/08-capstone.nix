# Capstone: strings
#
# This capstone combines interpolation, `toString`, indented strings and
# escapes. Predict the exact script text, as Nix writes it to a file. Write
# your answer as a double-quoted string.
{ __ }:

{
  script = {
    expr = ''
      #!/bin/sh
      PORT=${toString 8080}
      VERBOSE=${toString true}
      DEBUG=${toString false}
      echo "port ''${PORT}"
    '';
    expected = /*>*/ "#!/bin/sh\nPORT=8080\nVERBOSE=1\nDEBUG=\necho \"port \${PORT}\"\n" /*<*/;
  };
}
