{ pkgs, ... }:

{

	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

	services = {
		tlp.enable = true;
		blueman.enable = config.modules.bluetooth;
	};

	hardware = {
		bluetooth.enable = config.modules.bluetooth;
	};

	powerManagement.cpuFreqGovernor = "schedutil";
}
