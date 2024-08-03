{
  # Inspired by https://github.com/PaulGrandperrin/nix-systems.git

  description = "Antony Blakey system configuration";

  inputs = {

    flake-schemas.url = "github:DeterminateSystems/flake-schemas";

    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs = {
      type = "indirect"; # take it from the registry
      id = "nixpkgs";
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
      inputs.home-manager.follows = "home-manager";
    };

    nix-inspect = {
      url = "github:bluskript/nix-inspect";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs: {
    schemas = import ./schemas.nix inputs;
    overlays = import ./overlays.nix inputs;
    packages = import ./packages.nix inputs;
    darwinConfigurations = import ./darwinConfigurations.nix inputs;
  };
}
