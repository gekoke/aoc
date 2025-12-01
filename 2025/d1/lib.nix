{ lib, ... }:
let
  inherit (lib)
    elemAt
    map
    match
    mod
    readLines
    toInt
    ;
in
rec {

  lines = readLines ./input.txt;

  parseTurnAmount =
    str:
    let
      matches = match "([LR])([0-9]+)" str;
    in
    if matches == null then
      throw "parse error"
    else
      let
        sign = if elemAt matches 0 == "L" then -1 else 1;
        value = toInt (elemAt matches 1);
      in
      sign * value;

  turnAmounts = map parseTurnAmount lines;

  dialMod = x: mod x 100;

  normalizeToDial =
    x:
    let
      m = dialMod x;
    in
    if m < 0 then 100 + m else m;
}
