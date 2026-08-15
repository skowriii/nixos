{ config, pkgs, ... }:

{
	programs.obs-studio = if config.modules.obs then {
		enable = true;
		plugins = [pkgs.obs-studio-plugins.wlrobs];
	} else {};
}
