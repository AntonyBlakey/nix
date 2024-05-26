{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.users.antony.home = "/Users/antony";
  home-manager.users.antony = import ./home.nix;

	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; [
		vim
		curl
		gitAndTools.gitFull
    git-credential-manager
    devenv
	];

	# Auto upgrade nix package and the daemon service.
	services.nix-daemon.enable = true;
	# nix.package = pkgs.nix;
  nix.gc.automatic = true;

	# Necessary for using flakes on this system.
	nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;

  security.pam.enableSudoTouchIdAuth = true;

	# Create /etc/zshrc that loads the nix-darwin environment.
	programs.zsh.enable = true;

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
	system.stateVersion = 4;

	# The platform the configuration will be used on.
	nixpkgs.hostPlatform = "aarch64-darwin";
}
