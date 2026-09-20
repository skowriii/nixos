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
		./display-manager.nix
		./development.nix
		./desktop.nix
		./audio.nix
		./gaming.nix
		./extras/nbfc.nix
		./extras/cloudflare.nix
		./extras/docker.nix
		./extras/easyeffects.nix
		./extras/neovim.nix
		./extras/obs.nix
		./extras/opentabletdriver.nix
		./extras/spotify.nix
		./extras/tmux.nix
		./extras/virtualization.nix
		./extras/wine.nix
	];

	nix = {
		registry = { nixpkgs.flake = inputs.nixpkgs; };
		settings.experimental-features = ["nix-command" "flakes"];
	};

	nixpkgs.config.allowUnfree = true;

	modules = {
		displayManager = true;
		bluetooth = true;
		cloudflare = true;
		docker = true;
		easyeffects = true;
		neovim = true;
		obs = true;
		opentabletdriver = true;
		spotify = true;
		tmux = true;
		wine = true;
		osu-lazer = true;
	};
}
