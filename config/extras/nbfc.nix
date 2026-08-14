{ pkgs, globals, ... }:

{
	environment = {
		systemPackages = [pkgs.nbfc-linux];
		etc."nbfc/nbfc.json".text = builtins.toJSON { SelectedConfigId = globals.nbfcModel; };
	};

	systemd.services.nbfc_service = {
		enable = true;
		description = "NoteBook FanControl service";
		path = [pkgs.kmod];
		serviceConfig = {
			Type = "simple";
			# Drop any saved fixed fan speed. Without this a manual "nbfc set -s"
			# survives reboots and silently disables the profile's fan curve.
			ExecStartPre = "${pkgs.coreutils}/bin/rm -f /var/lib/nbfc/state.json";
			ExecStart = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file /etc/nbfc/nbfc.json";
			Restart = "on-failure";
			RestartSec = 5;
			StateDirectory = "nbfc";
		};
		startLimitIntervalSec = 60;
		wantedBy = ["multi-user.target"];
	};
}
