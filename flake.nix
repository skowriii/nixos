{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};
		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
		nixosConfigurations.nixbob = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
				globals = import ./config/shared/globals.nix;
			};
			modules = [./config/configuration.nix];
		};
	};
}
