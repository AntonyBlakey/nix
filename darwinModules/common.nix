{ inputs, lib, pkgs, config, ... }: {

  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

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

  nixpkgs = {
    overlays = [
      (import ../overlays.nix inputs).default # adds local packages to nixpkgs
    ];
    # config = import ../../nixpkgs/config.nix;
  };

  nixpkgs.config.allowUnfree = true;

  users.users.antony.home = "/Users/antony";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = config._module.specialArgs;
  home-manager.users.antony =
    {
      imports = [ ../homeModules/home-manager.nix ];
    };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = lib.mkDefault pkgs.nix;
    gc.automatic = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # auto-optimise-store = true; # maybe causes build failures
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

}
