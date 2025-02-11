inputs:
let
  mkDarwinConfig =
    modules:
    inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      inherit modules;
      specialArgs = {
        inherit inputs;
      };
    };
in
{
  Bach = mkDarwinConfig [
    ../modules/darwin/common.nix
    # ../modules/darwin/homebrew.nix
  ];
}
