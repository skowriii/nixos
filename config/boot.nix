{ pkgs, ... }:

{
	environment.systemPackages = [pkgs.efibootmgr];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			timeout = 1;
		};
		kernelPackages = pkgs.linuxPackages;
		kernelParams = [
			"cfg80211.ieee80211_regdom=PL" # Configures regulatory domain for wireless networks to PL (Poland)
		];
		kernel.sysctl = {
			"vm.swappiness" = 150;
			"vm.page-cluster" = 0;
			"vm.max_map_count" = 2147483642;
		};
	};
}
