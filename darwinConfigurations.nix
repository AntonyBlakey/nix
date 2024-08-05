inputs:
let
  mkDarwinConfig = module:
    inputs.darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [ module ];
      system = "aarch64-darwin";
    };
in
{
  Bach = mkDarwinConfig ./darwinModules/common.nix;
}
