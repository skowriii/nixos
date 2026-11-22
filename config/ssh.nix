{ ... }:

{
	services.openssh = {
		enable = true;
		openFirewall = true;
		ports = [7032];
		allowSFTP = true;
		hostKeys = [
			{
				bits = 4096;
				path = "/etc/ssh/server";
				type = "ed25519";
			}
		];
		settings = {
			PermitRootLogin = "no";
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
			UsePAM = true;
			X11Forwarding = false;
			PrintMotd = false;
			AcceptEnv = ["LANG" "LANG_*" "COLORTERM" "NO_COLOR"];
			AllowUsers = ["skowriii"];
		};
		extraConfig = "PubkeyAuthentication yes";
	};
}
