{ pkgs, ... }:

{
	programs.tmux.enable = true;

	environment.systemPackages = [pkgs.smug];
}
