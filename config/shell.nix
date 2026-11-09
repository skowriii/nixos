{ pkgs, globals, ... }:

{
	programs = {
		bat.enable = true;
		foot.enable = true;
		fzf.fuzzyCompletion = true;
		lazygit.enable = true;
		zoxide.enable = true;
		zsh.enable = true;
		direnv.enable = true;
	};

	environment.systemPackages = with pkgs; [
		acpi
		acpica-tools
		aria2
		brightnessctl
		btop
		codex
		curl
		duf
		eza
		fastfetch
		git
		hydra-check
		(globals.getFromCache { package = "jellyfin-tui"; pkgs = pkgs; })
		ncdu
		ugrep
		unrar
		unzip
		rivalcfg
		pass
		socat
		(globals.getFromCache { package = "taskwarrior3"; pkgs = pkgs; })
		tealdeer
		wget
		zip
	];
}
