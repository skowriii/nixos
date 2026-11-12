{ config, pkgs, lib, ... }:

{
	environment.systemPackages = [pkgs.efibootmgr];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			timeout = 1;
		};
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		kernelParams = [
			"amdgpu.dcdebugmask=0x410" # Fixes certain screen bugs
			"nowatchdog" # Disables watchdog
			"nvme_core.default_ps_max_latency_us=0" # Disables the most aggressive NVME disk sleep states
			"audit=0" # Turns off kernel security auditing
			"spec_store_bypass_disable=prctl" # Disables SSB (Speculative Store Bypass) mitigation globally
			"cfg80211.ieee80211_regdom=PL" # Configures regulatory domain for wireless networks to PL (Poland)
			"split_lock_mitigate=0" # Disables mitigation for "split lock" instructions
		];
		kernel.sysctl = {
			"vm.swappiness" = 150;
			"vm.page-cluster" = 0;
			"vm.max_map_count" = 2147483642;
		};
		extraModprobeConfig = lib.mkIf config.modules.bluetooth "options bluetooth disable_ertm=Y";
	};
}
