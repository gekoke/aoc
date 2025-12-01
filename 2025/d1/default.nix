{
  lib,
}:
let
  inherit (lib)
    countEq
    elemAt
    map
    match
    mod
    readLines
    scan1
    toInt
    ;

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

  turn = curr: amount: normalizeToDial (curr + amount);

  startingPosition = 50;
  positions = scan1 turn startingPosition turnAmounts;
in
countEq 0 positions
