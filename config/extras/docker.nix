{ config, pkgs, ... }:

{
	virtualisation.docker = if config.modules.docker then {
		enable = true;
		enableOnBoot = false;
		autoPrune = {
			enable = true;
			persistent = true;
		};
		extraPackages = [pkgs.docker-compose];
	} else {};

	users.users.skowriii.extraGroups = if config.modules.docker then ["docker"] else [];
}
