{ inputs, ... }:

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
		registry = { nixpkgs.flake = inputs.nixpkgs; };
		settings.experimental-features = ["nix-command" "flakes"];
	};

	nixpkgs.config.allowUnfree = true;

	modules = {
		displayManager = true;
		bluetooth = true;
		printer = false;
		nbfc = false;
		cloudflare = true;
		docker = true;
		easyeffects = true;
		neovim = true;
		obs = true;
		opentabletdriver = true;
		spotify = true;
		tmux = true;
		virtualization = false;
		wine = true;
		osu-lazer = true;
	};
}
