inputs:
let
  mkDarwinConfig = modules:
    inputs.darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      system = "aarch64-darwin";
      modules = modules;
    };
in
{
  Bach = mkDarwinConfig [ ./darwinModules/common.nix ./darwinModules/homebrew.nix ];
}
