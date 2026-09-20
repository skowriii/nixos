{ pkgs, ... }:

{
	time.timeZone = "Europe/Warsaw";

	i18n = {
		supportedLocales = ["pl_PL.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
		defaultLocale = "pl_PL.UTF-8";
	};

	console = {
		enable = true;
		font = "lat2-16";
		keyMap = "pl";
	};

	programs = {
		nh.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

	services = {
		tlp.enable = true;
		nohang.enable = true;
		irqbalance.enable = true;
		zram-generator = {
			enable = true;
			settings.zram0 = {
				zram-size = "ram";
				compression-algorithm = "zstd";
			};
		};
		libinput.enable = true;
		nextdns = {
			enable = true;
			arguments = ["-cache-size" "10MB"];
		};
		blueman.enable = config.modules.bluetooth;
	};

	systemd = {
		oomd.enable = false;
	};

	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		amdgpu.overdrive.enable = true;
		bluetooth.enable = config.modules.bluetooth;
	};

	powerManagement.cpuFreqGovernor = "schedutil";

	system.stateVersion = "26.11";
}
