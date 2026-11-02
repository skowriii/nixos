{ config, pkgs, lib, ... }:

{
	programs = {
		gamemode = {
			enable = true;
			enableRenice = true;
		};
		gamescope = {
			enable = true;
			enableWsi = true;
			args = [
				"-W" "1920"
				"-H" "1080"
			];
		};
		steam = {
			enable = true;
			protontricks.enable = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
			remotePlay.openFirewall = true;
		};
	};

	environment.systemPackages = with pkgs; []
		++ lib.optionals config.modules.osu-lazer
			[osu-lazer-bin]
		++ lib.optionals config.modules.minecraft
			[prismlauncher];

	hardware.xpadneo.enable = config.modules.bluetooth;

	boot.extraModprobeConfig = lib.mkIf config.modules.bluetooth "options hid_xpadneo disable_shift_mode=Y";
}
