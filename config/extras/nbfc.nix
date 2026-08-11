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
			ExecStart = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file /etc/nbfc/nbfc.json";
			Restart = "on-failure";
			RestartSec = 5;
			StateDirectory = "nbfc";
		};
		wantedBy = ["multi-user.target"];
	};
}
