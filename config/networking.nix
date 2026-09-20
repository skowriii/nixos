{ globals, ... }:

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
	};
}
