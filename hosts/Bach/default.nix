{ pkgs, inputs, ... }:

let
	inherit (inputs) home-manager gitcm;
	gitcmpkgs = import gitcm { inherit pkgs; };
in {

	nix.useDaemon = true;

	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	#home-manager.users.antony = import ./home.nix { inherit pkgs; };

	environment.systemPackages = [
		gitcmpkgs.git-credential-manager
    ];
	
	# you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
	programs.zsh.enable = true;

	services.nix-daemon.enable = true;
	nix.package = pkgs.nixFlakes;
 	nix.gc.automatic = true;

	nix.settings.experimental-features = "nix-command flakes";
	nix.settings.auto-optimise-store = true;
	
	#homebrew = {
	#	enable = true;
	#	onActivation.autoUpdate = true;
	#	onActivation.upgrade = true;
	#	casks = [
	#		# "hammerspoon"
	#	];
	#};

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
	system.stateVersion = 4;
}