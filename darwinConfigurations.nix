inputs:
let
  mkDarwinConfig =
    modules:
    inputs.darwin.lib.darwinSystem {
      inherit modules;
      specialArgs = {
        inherit inputs;
      };
      system = "aarch64-darwin";
    };
in
{
  Bach = mkDarwinConfig [
    ./modules/darwin/common.nix
    ./modules/darwin/homebrew.nix
  ];
}
