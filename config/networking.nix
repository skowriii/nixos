{ config, ... }:

let
	mkWifi = { ssid, var }: {
		connection = {
			id = ssid;
			type = "wifi";
			interface-name = "wlp2s0";
		};
		wifi = {
			mode = "infrastructure";
			ssid = ssid;
		};
		wifi-security = {
			auth-alg = "open";
			key-mgmt = "wpa-psk";
			psk = "\${${var}}";
		};
		ipv4 = { method = "auto"; };
		ipv6 = {
			addr-gen-mode = "default";
			method = "auto";
		};
	};
in
{
	networking = {
		hostName = "nixbob";
		firewall = {
			enable = true;
			allowedTCPPorts = [
				7844 # Cloudflared Tunnels
				9385 # spotifyd discovery over local network
				31536 # qBittorrent - incoming connections from peers
				57621 # Spotify Connect
			];
			allowedUDPPorts = [
				1900 # SSDP - qBittorrent and Spotify
				5353 # mDNS - Spotify Connect
				6771 # qBittorrent
				7844 # Cloudflared Tunnels
				31536 # qBittorrent
				57621 # Spotify Connect
			];
		};
		networkmanager = {
			enable = true;
			ensureProfiles = {
				environmentFiles = [config.sops.templates."networkmanager.env".path];
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
					freewifi = mkWifi { ssid = "freewifi"; var = "FREEWIFI_PSK"; };
					MIM-KOMPUTER_Network = mkWifi { ssid = "MIM-KOMPUTER_Network"; var = "MIM_KOMPUTER_NETWORK_PSK"; };
				};
			};
		};
	};
}
