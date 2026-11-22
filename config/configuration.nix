{ pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./boot.nix
		./networking.nix
		./shell.nix
	];

	nix = {
		registry.nixpkgs.flake = inputs.nixpkgs;
		settings = {
			experimental-features = ["nix-command" "flakes"];
			extra-substituters = ["https://nix-community.cachix.org"];
			extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
			auto-optimise-store = true;
		};
	};

	nixpkgs.config.allowUnfree = true;
}
