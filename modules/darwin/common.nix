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
  # sudo dseditgroup -o edit -a antony -t user wheel
  users.groups.wheel.members = [ "antony" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = config._module.specialArgs; # pulls inputs into home-manager
    users = {
      antony = {
        imports = [
          ../home/core.nix
          ../home/git.nix
          ../home/cmdline.nix
          ../home/nix-tools.nix
        ];
      };
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

}
