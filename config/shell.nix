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
		atac
		bleachbit
		brightnessctl
		btop
		curl
		duf
		eza
		fastfetch
		git
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
