inputs:
let
  mkDarwinConfig = module:
    inputs.darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [ module ];
    };
in
{
  Bach = mkDarwinConfig ./darwinModules/Bach.nix;
}
