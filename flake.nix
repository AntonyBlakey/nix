{
  description = "Antony Blakey system configuration";

  inputs = {
    nixpkgs =
      {
        url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, nixvim } @ inputs: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Bach
    darwinConfigurations = {
      Bach = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.antony = import ./hosts/Bach/home-manager.nix;
            home-manager.sharedModules = [
              nixvim.homeManagerModules.nixvim
            ];
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
