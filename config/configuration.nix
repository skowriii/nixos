{ pkgs, inputs, ... }:

{
	imports = [
		./shared/options.nix
		./hardware-configuration.nix
		./filesystems.nix
		./boot.nix
		./base.nix
		./networking.nix
		./users/skowriii/skowriii.nix
		./home-manager.nix
		./shell.nix
		./desktop.nix
		./audio.nix
		./gaming.nix
		./extras.nix
	];

	nix = {
		registry = {
			nixpkgs.flake = inputs.nixpkgs;
			nixpkgs.to = {
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
			substituters = ["https://nix-community.cachix.org"];
			trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
			auto-optimise-store = true;
		};
	};

	nixpkgs.config.allowUnfree = true;

	modules = {
		displayManager = true;
		bluetooth = true;
		printer = false;
		nbfc = false;
		cloudflare = true;
		docker = true;
		easyeffects = false;
		neovim = true;
		obs = false;
		opentabletdriver = true;
		spotify = true;
		tmux = true;
		virtualization = false;
		wine = true;
		osu-lazer = true;
	};
}
