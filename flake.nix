{
  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      flake = {
        lib = import ./lib.nix { inherit (inputs.nixpkgs) lib; };
        solution = {
          y2025 = {
            d1 = import ./2025/1 { inherit (inputs.self) lib; };
          };
        };
      };
    };
}
