{ inputs, ... }:
{

  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  # https://github.com/zhaofengli/nix-homebrew
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = false;

    # User owning the Homebrew prefix
    user = "antony";

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = true;
  };

  # https://github.com/malob/nixpkgs/blob/master/darwin/homebrew.nix
  homebrew.enable = true;
  homebrew.casks = [
    # "kitty"
  ];

}
