{ inputs, ... }:

{
	nix = {
		registry = { nixpkgs.flake = inputs.nixpkgs; };
		settings = {
			max-jobs = 2;
			cores = 2;
			experimental-features = ["nix-command" "flakes"];
		};
	};

	nixpkgs.config.allowUnfree = true;

	imports = [
		./hardware-configuration.nix
		./filesystems.nix
		./boot.nix
		./base.nix
		./networkmanager.nix
		./documentation.nix
		./users/skowriii/skowriii.nix
		./shell.nix
		./display-manager.nix
		./development.nix
		./desktop.nix
		./audio.nix
		./bluetooth.nix
		./fonts.nix
		./gaming.nix
		# ./printer.nix
		./systemd.nix
		./extras/cloudflare.nix
		./extras/docker.nix
		./extras/easyeffects.nix
		./extras/neovim.nix
		./extras/obs.nix
		# ./extras/opentabletdriver.nix
		./extras/spotify.nix
		./extras/tmux.nix
		# ./extras/virtualization.nix
		./extras/wine.nix
		./specializations/gaming.nix
	];

	system.stateVersion = "26.05";
}
