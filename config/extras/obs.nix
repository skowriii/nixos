{ config, pkgs, ... }:

{
	programs.obs-studio = if config.modules.obs then {
		enable = true;
		plugins = with pkgs.obs-studio-plugins; [obs-pipewire-audio-capture obs-vaapi];
	} else {};
}
