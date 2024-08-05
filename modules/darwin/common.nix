{ inputs, config, ... }:
{

  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../config/nix.nix
  ];

  nixpkgs = {
    overlays = [ (import ../../overlays inputs).default ];
    config = import ../../config/pkgs.nix;
  };

  users.users.antony.home = "/Users/antony";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = config._module.specialArgs; # pulls inputs into home-manager
    users = {
      antony = {
        imports = [ ../home/common.nix ];
      };
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

}
