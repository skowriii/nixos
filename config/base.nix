{ pkgs, ... }:

{
	networking = {
		hostName = "nixbob";
		firewall = {
			enable = true;
			allowedTCPPorts = [
				31536 # qBittorrent - incoming connections from peers
				57621 # Spotify Connect
			];
			allowedUDPPorts = [
				1900 # SSDP - qBittorrent and Spotify
				5353 # mDNS - Spotify Connect
				6771 # qBittorrent
				31536 # qBittorrent
				57621 # Spotify Connect
			];
		};
	};

	time.timeZone = "Europe/Warsaw";

	i18n.defaultLocale = "pl_PL.UTF-8";

	console = {
		enable = true;
		font = "lat2-16";
		keyMap = "pl";
	};

	environment.systemPackages = with pkgs; [git curl wget mold brightnessctl udiskie acpi acpica-tools];

	programs = {
		nh = {
			enable = true;
			clean = {
				enable = true;
				dates = "weekly";
				extraArgs = "--keep 3";
			};
		};
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		nix-ld.enable = true;
	};

	services = {
		nohang.enable = true;
		irqbalance.enable = true;
		tlp.enable = true;
		zram-generator = {
			enable = true;
			settings.zram0 = {
				zram-size = "ram";
				compression-algorithm = "zstd";
			};
		};
		libinput.enable = true;
		openssh.enable = true;
	};

	systemd.oomd.enable = false;

	boot.kernel.sysctl = {
		"vm.swappiness" = 130;
		"vm.page-cluster" = 0;
	};

	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		amdgpu.overdrive.enable = true;
	};

	powerManagement.cpuFreqGovernor = "schedutil";
}
