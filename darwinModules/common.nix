{ inputs, lib, pkgs, config, ... }: {

  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  nixpkgs = {
    overlays = [
      (import ../overlays.nix inputs).default # adds local packages to nixpkgs
    ];
    # config = import ../../nixpkgs/config.nix;
  };

  nixpkgs.config.allowUnfree = true;

  users.users.antony.home = "/Users/antony";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = config._module.specialArgs;
    users = {
      antony = {
        imports = [ ../homeModules/common.nix ];
      };
    };
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
