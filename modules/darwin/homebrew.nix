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
    group = "staff";

    mutableTaps = true;
  };

  homebrew.enable = true;
  homebrew.casks = [ "nikitabobko/tap/aerospace" ];

}
