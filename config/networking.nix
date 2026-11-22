{ config, ... }:

{
	networking = {
		hostName = "skurwiii";
		firewall.enable = true;
		networkmanager = {
			enable = true;
			ensureProfiles = {
				environmentFiles = [config.sops.templates."networkmanager.env".path];
				profiles.freewifi = {
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
}
