{
  description = "Antony Blakey system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

     home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, home-manager, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Bach
    darwinConfigurations = {
      Bach = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
        	  home-manager.useUserPackages = true;
        	  home-manager.users.antony = import ./hosts/Bach/home-manager.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
