{ pkgs, inputs, ... }:

{
	imports = [./options.nix];

	modules = {
		displayManager = true;
		bluetooth = true;
		nbfc = true;
	};

	nixpkgs.config.allowUnfree = true;

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

	programs = {
		nh = {
			enable = true;
			clean = {
				enable = true;
				dates = "Sun *-*-* 22:00:00";
			};
		};
	};

	environment.systemPackages = with pkgs; [
		git
		curl
		wget
		mold
		brightnessctl
		nextdns
		vim
		fuzzel
		inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	];

	services = {
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

	system.stateVersion = "26.05";
}
