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

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = { };

    taps = [ ];

    # `brew install`
    brews = [ ];

    # `brew install --cask`
    casks = [ ];
  };

}
