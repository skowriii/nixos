{ pkgs, globals, ... }:

{
	systemd.services = {
		NetworkManager-wait-online.enable = false;
		fix-usb-wakeup = {
			enable = false;
			description = "Whitelist keyboard for ACPI wakeup";
			after = ["multi-user.target"];
			wantedBy = ["multi-user.target"];
			serviceConfig = {
				Type = "oneshot";
				RemainAfterExit = true;
				ExecStart = pkgs.writeShellScript "fix-usb-wakeup" ''
					if [[ $(${pkgs.coreutils}/bin/cat /proc/acpi/wakeup | \
						${pkgs.gawk}/bin/awk '{ if ($1 == "XHC0") print $3 }' | \
						${pkgs.gnused}/bin/sed 's/*//g') = "enabled" ]]; then
						echo XHC0 > /proc/acpi/wakeup
					fi
				'';
			};
		};
		network-reconnected = {
			description = "Update NextDNS related IP address";
			after = ["network-online.target"];
			wants = ["network-online.target"];
			wantedBy = ["multi-user.target"];
			serviceConfig = {
				Type = "oneshot";
				EnvironmentFile = "${globals.rootDirectory}/secrets/nextdns.env";
				ExecStart = "${pkgs.curl}/bin/curl --fail --silent --show-error \${NEXTDNS_LINK_IP_URL}";
			};
		};
	};
}
