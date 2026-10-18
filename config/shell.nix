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
		# cmake
		curl
		duf
		eza
		fastfetch
		# gdb
		git
		# gitleaks
		hydra-check
		jellyfin-tui
		ncdu
		# osv-scanner
		ugrep
		unrar
		unzip
		rivalcfg
		pass
		# semgrep
		socat
		taskwarrior3
		tealdeer
		wget
		# zig
		zip
	];
}
