{ config, ... }:

{
	services.silverbullet = {
		enable = true;
		envFile = config.sops.templates."silverbullet.env".path;
		openFirewall = true;
		spaceDir = "/mnt/silverbullet";
		listenPort = 5117;
		listenAddress = "0.0.0.0";
	};
}
