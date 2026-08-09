{ pkgs, ... }:

{
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		kernelParams = [
			"amdgpu.dcdebugmask=0x410"
			"nowatchdog"
			"nvme_core.default_ps_max_latency_us=0"
			"audit=0" "spec_store_bypass_disable=prctl"
			"cfg80211.ieee80211_regdom=PL"
		];
	};
}
