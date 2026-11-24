{ lib, ... }:

{
	options.modules = {
		displayManager = lib.mkEnableOption "a display manager";
		bluetooth = lib.mkEnableOption "Bluetooth";
		printer = lib.mkEnableOption "printer";
		nbfc = lib.mkEnableOption "nbfc";
		cloudflare = lib.mkEnableOption "Cloudflare";
		docker = lib.mkEnableOption "Docker";
		easyeffects = lib.mkEnableOption "EasyEffects";
		neovim = lib.mkEnableOption "NeoVim";
		obs = lib.mkEnableOption "OBS";
		opentabletdriver = lib.mkEnableOption "OpenTabletDriver";
		spotify = lib.mkEnableOption "Spotify";
		tmux = lib.mkEnableOption "tmux";
		virtualization = lib.mkEnableOption "virtualization";
		wine = lib.mkEnableOption "WINE";
		osu-lazer = lib.mkEnableOption "osu!lazer";
		minecraft = lib.mkEnableOption "Minecraft";
		osrs = lib.mkEnableOption "Old School RuneScape";
	};
}
