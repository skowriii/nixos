{ globals, ... }:

{
	networking = {
		hostName = "nixbob";
		firewall = {
			enable = true;
			allowedTCPPorts = [
				9385 # spotifyd discovery over local network
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
		networkmanager = {
			enable = true;
			ensureProfiles = {
				environmentFiles = ["${globals.rootDirectory}/secrets/networkmanager.env"];
				profiles = {
					freeethernet = {
						connection = {
							id = "freeethernet";
							type = "ethernet";
							autoconnect-priority = 999;
							interface-name = "enp1s0";
						};
						ethernet = {
							duplex = "full";
							speed = 1000;
						};
						ipv4 = {
							address1 = "192.168.9.100/24";
							dns = "45.90.28.250;45.90.30.250";
							gateway = "192.168.9.1";
							method = "manual";
						};
						ipv6 = {
							addr-gen-mode = "stable-privacy";
							method = "disabled";
						};
					};
					freeethernet-cloudflare = {
						connection = {
							id = "freeethernet-cloudflare";
							type = "ethernet";
							autoconnect-priority = 998;
							interface-name = "enp1s0";
						};
						ethernet = {
							duplex = "full";
							speed = 1000;
						};
						ipv4 = {
							address1 = "192.168.9.100/24";
							dns = "1.1.1.1;1.0.0.1";
							gateway = "192.168.9.1";
							method = "manual";
						};
						ipv6 = {
							addr-gen-mode = "stable-privacy";
							method = "disabled";
						};
					};
					freewifi = {
						connection = {
							id = "freewifi";
							type = "wifi";
							interface-name = "wlp2s0";
						};
						wifi = {
							mode = "infrastructure";
							ssid = "freewifi";
						};
						wifi-security = {
							auth-alg = "open";
							key-mgmt = "wpa-psk";
							psk = "\${FREEWIFI_PSK}";
						};
						ipv4 = { method = "auto"; };
						ipv6 = {
							addr-gen-mode = "default";
							method = "auto";
						};
					};
				};
			};
		};
	};
}
