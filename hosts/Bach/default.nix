{ pkgs, home-manager, ... }:
{
  nix.useDaemon = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  # Will be fixed in Nix eventually
  users.users.antony.home = "/Users/antony";
  home-manager.users.antony = import ./home.nix { inherit pkgs; };

  environment.systemPackages = [
    pkgs.git-credential-manager
  ];

  # enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;

  services.nix-daemon.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.gc.automatic = true;

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
