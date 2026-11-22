{ config, ... }:

{
	systemd.tmpfiles.settings."10-mnt" = {
		"/mnt".d = {
			user = "root";
			group = "root";
			mode = "0755";
			age = "-";
		};
		"/mnt/silverbullet".d = {
			user = config.services.silverbullet.user;
			group = config.services.silverbullet.group;
			mode = "0770";
			age = "-";
		};
		"/mnt/music".d = {
			user = "skowriii";
			group = "users";
			mode = "0770";
			age = "-";
		};
	};
}
