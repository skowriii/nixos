{ config, pkgs, lib, ... }:

{
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			timeout = 1;
		};
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		kernelParams = [
			"amdgpu.dcdebugmask=0x410"
			"nowatchdog"
			"nvme_core.default_ps_max_latency_us=0"
			"audit=0" "spec_store_bypass_disable=prctl"
			"cfg80211.ieee80211_regdom=PL"
			"split_lock_mitigate=0"
		];
		kernel.sysctl = {
			"vm.swappiness" = 150;
			"vm.page-cluster" = 0;
			"vm.max_map_count" = 2147483642;
		};
		extraModprobeConfig = lib.mkIf config.modules.bluetooth "options bluetooth disable_ertm=Y";
	};
}
