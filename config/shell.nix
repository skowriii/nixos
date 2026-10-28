{ pkgs, ... }:

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
		jellyfin-tui
		ncdu
		ugrep
		unrar
		unzip
		rivalcfg
		pass
		socat
		taskwarrior3
		tealdeer
		wget
		zip
	];
}
