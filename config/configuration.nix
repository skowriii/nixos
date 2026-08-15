{ inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./filesystems.nix
		./shared/common.nix
		./boot.nix
		./base.nix
		./networkmanager.nix
		./documentation.nix
		./users/skowriii/skowriii.nix
		./home-manager.nix
		./shell.nix
		./display-manager.nix
		./development.nix
		./desktop.nix
		./audio.nix
		./bluetooth.nix
		./fonts.nix
		./gaming.nix
		./printer.nix
		./systemd.nix
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
		./specializations/gaming.nix
	];

	nix = {
		registry = { nixpkgs.flake = inputs.nixpkgs; };
		settings.experimental-features = ["nix-command" "flakes"];
	};

	modules = {
		cloudflare = true;
		docker = true;
		easyeffects = true;
		neovim = true;
		obs = true;
		spotify = true;
		tmux = true;
		wine = true;
	};
}
