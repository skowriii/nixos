{ pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./boot.nix
		./logind.nix
		./networking.nix
		./ssh.nix
		./mnt.nix
		./shell.nix
		./spotdl.nix
		./navidrome.nix
		./silverbullet.nix
	];

	nix = {
		registry.nixpkgs = {
			flake = inputs.nixpkgs;
			to = {
				type = "path";
				path = pkgs.path;
				narHash = builtins.readFile
					(pkgs.buildPackages.runCommandLocal "get-nixpkgs-hash"
					 { nativeBuildInputs = [pkgs.buildPackages.nix]; }
					 "nix-hash --type sha256 --sri ${pkgs.path} > $out");
			};
		};
		settings = {
			experimental-features = ["nix-command" "flakes"];
			extra-substituters = ["https://nix-community.cachix.org"];
			extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
			auto-optimise-store = true;
		};
	};

	nixpkgs.config.allowUnfree = true;

	system.stateVersion = "26.05";
}
