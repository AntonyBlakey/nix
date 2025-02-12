{
  # Inspired by
  # - https://github.com/PaulGrandperrin/nix-systems.git
  # - https://github.com/dustinlyons/nixos-config.git

  description = "Antony Blakey system configuration";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-inspect = {
      url = "github:bluskript/nix-inspect";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-homebrew = {
    #   url = "github:zhaofengli-wip/nix-homebrew";
    #   inputs.nix-darwin.follows = "darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };

  outputs =
    inputs:
    let
      inputs_with_lib = inputs // {
        lib = inputs.nixpkgs.lib;
      };
    in
    {
      inherit inputs_with_lib;

      darwinConfigurations = import ./systems/darwin.nix inputs_with_lib;
    };
}
