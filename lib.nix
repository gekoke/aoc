{ lib, ... }:
lib.extend (
  _final: _prev:
  let
    inherit (lib)
      count
      filter
      head
      pipe
      readFile
      splitString
      tail
      ;
  in
  rec {
    splitLines = splitString "\n";

    readLines =
      path:
      pipe (readFile path) [
        splitLines
        (filter (line: line != ""))
      ];

    scan =
      f: init: xs:
      let
        go =
          acc: xs:
          let
            acc' = f acc (head xs);
          in
          if xs == [ ] then [ acc ] else [ acc ] ++ go acc' (tail xs);
      in
      go init xs;

    scan1 =
      f: init: xs:
      tail (scan f init xs);

    countEq = x: count (y: y == x);
  }
)
