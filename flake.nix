{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser = {
			url = "github:youwen5/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprqt6engine = {
			url = "github:hyprwm/hyprqt6engine";
			inputs.nixpkgs.follows = "nixpkgs";
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
				globals = import ./config/globals.nix;
			};
			modules = [
				./config/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.startAsUserService = true;
					home-manager.extraSpecialArgs = {
						inherit inputs;
						globals = import ./config/globals.nix;
					};
					home-manager.users.skowriii = ./config/users/home.nix;
				}
			];
		};
	};
}
