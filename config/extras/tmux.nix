{ config, pkgs, ... }:

{
	programs.tmux.enable = config.modules.tmux;

	environment.systemPackages = if config.modules.tmux then [pkgs.smug] else [];
}
