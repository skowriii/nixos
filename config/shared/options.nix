{ lib, ... }:

{
	options = {
		specializationType = lib.mkOption {
			description = "Indicates which, if any, specialization is currently running.";
			type = lib.types.enum [
				"none"
				"gaming"
			];
			default = "none";
		};
		modules = {
			displayManager = lib.mkEnableOption "a display manager";
			bluetooth = lib.mkEnableOption "bluetooth";
			printer = lib.mkEnableOption "printer";
			nbfc = lib.mkEnableOption "nbfc";
			cloudflare = lib.mkEnableOption "cloudflare";
			docker = lib.mkEnableOption "docker";
			easyeffects = lib.mkEnableOption "easyeffects";
			neovim = lib.mkEnableOption "neovim";
			obs = lib.mkEnableOption "obs";
			opentabletdriver = lib.mkEnableOption "opentabletdriver";
			spotify = lib.mkEnableOption "spotify";
			tmux = lib.mkEnableOption "tmux";
			virtualization = lib.mkEnableOption "virtualization";
			wine = lib.mkEnableOption "wine";
			osu-lazer = lib.mkEnableOption "osu!lazer";
		};
	};
}
