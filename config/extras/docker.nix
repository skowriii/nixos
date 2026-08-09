{ pkgs, ... }:

{
	virtualisation.docker = {
		enable = true;
		enableOnBoot = false;
		rootless.enable = true;
		autoPrune = {
			enable = true;
			persistent = true;
		};
		extraPackages = [pkgs.docker-compose];
	};

	users.users.skowriii.extraGroups = ["docker"];
}
