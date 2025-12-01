{
  lib,
}:
let
  inherit (lib)
    scan1
    countEq
    ;
  inherit (import ./lib.nix { inherit lib; })
    normalizeToDial
    turnAmounts
    ;

  turn = curr: amount: normalizeToDial (curr + amount);

  startingPosition = 50;
  positions = scan1 turn startingPosition turnAmounts;
in
countEq 0 positions
