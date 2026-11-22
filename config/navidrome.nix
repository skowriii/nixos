{ pkgs, ... }:

{
	services.navidrome = {
		enable = true;
		openFirewall = true;
		plugins = [pkgs.navidromePlugins.discord-rich-presence];
		settings = {
			MusicFolder = "/mnt/music";
			Address = "0.0.0.0";
		};
	};
}
