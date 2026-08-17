{ pkgs, ... }:

{
	programs = {
		bat.enable = true;
		fzf.fuzzyCompletion = true;
		lazygit.enable = true;
		zoxide.enable = true;
		zsh.enable = true;
		foot.enable = true;
	};

	environment.systemPackages = with pkgs; [
		aria2
		atac
		bleachbit
		btop
		duf
		eza
		fastfetch
		ncdu
		ugrep
		unrar
		unzip
		rivalcfg
		pass
		socat
		taskwarrior3
		tealdeer
		zip
	];
}
