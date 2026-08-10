{ pkgs, ... }:

{
	programs = {
		bat.enable = true;
		fzf.fuzzyCompletion = true;
		lazygit.enable = true;
		zoxide.enable = true;
		zsh = {
			enable = true;
			# loginShellInit = ''
			# 	if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
			# 		exec start-hyprland
			# 	fi
			# '';
		};
		foot.enable = true;
	};

	environment.systemPackages = with pkgs; [
		aria2
		atac
		bleachbit
		btop
		direnv
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
