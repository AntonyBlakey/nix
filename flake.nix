{
	description = "Antony's Nix Configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		darwin = {
			url = "github:lnl7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#nurpkgs = {
		#	url = "github:nix-community/NUR/40cd392b888a4d78044d733b9fee61710f749a05";
		#	flake = false;
		#};
		
		gitcm = {
			url = "github:AntonyBlakey/NUR/05621052d7f290c12c1281339b6f898505ff35a6";
			flake = false;
		};
	};
	
	outputs = { self, nixpkgs, home-manager, darwin, gitcm }@inputs:
	{
		darwinConfigurations = {
			Bach = darwin.lib.darwinSystem {
				system = "aarch64-darwin";
				modules = [ 
					./hosts/Bach/default.nix
				];
				specialArgs = { inherit inputs; };
			};
		};

	};

}