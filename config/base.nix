{ config, lib, pkgs, ... }:

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

	documentation.nixos.enable = false;

	programs = {
		nh.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		system-config-printer.enable = config.modules.printer;
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
		greetd = lib.mkIf config.modules.displayManager {
			enable = true;
			useTextGreeter = true;
			settings = {
				default_session = {
					user = "greeter";
					command = lib.getExe' pkgs.tuigreet "tuigreet";
				};
			};
		};
		blueman.enable = config.modules.bluetooth;
		printing = lib.mkIf config.modules.printer {
			enable = true;
			cups-pdf.enable = true;
			drivers = with pkgs; [gutenprint hplip splix];
		};
	};

	systemd = {
		oomd.enable = false;
		services.NetworkManager-wait-online.enable = false;
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
