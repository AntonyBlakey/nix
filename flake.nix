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

    nur = {
      url = "github:nix-community/NUR/40cd392b888a4d78044d733b9fee61710f749a05";
      flake = false;
    };

    gitcm = {
      url = "github:AntonyBlakey/NUR/05621052d7f290c12c1281339b6f898505ff35a6";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nur, gitcm }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Bach
    darwinConfigurations = {
      Bach = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/Bach/default.nix
          # { 
          # 	# Set Git commit hash for darwin-version.
          # 	system.configurationRevision = self.rev or self.dirtyRev or null;
          # }
          home-manager.darwinModules.home-manager
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.Bach.pkgs;
  };
}
