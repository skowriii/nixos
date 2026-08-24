{ config, pkgs, ... }:

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

	environment.systemPackages = if config.modules.osu-lazer then [pkgs.osu-lazer-bin] else [];

	hardware.xpadneo.enable = config.modules.bluetooth;

	boot = {
		extraModprobeConfig = if config.modules.bluetooth then "options hid_xpadneo disable_shift_mode=Y" else "";
		kernel.sysctl."vm.max_map_count" = 2147483642;
	};
}
