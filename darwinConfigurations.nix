inputs:
let
  mkDarwinConfig = modules:
    inputs.darwin.lib.darwinSystem {
      inherit modules;
      specialArgs = { inherit inputs; };
      system = "aarch64-darwin";
    };
in
{
  Bach = mkDarwinConfig [ ./darwinModules/common.nix ./darwinModules/homebrew.nix ];
}
