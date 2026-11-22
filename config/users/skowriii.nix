{ pkgs, config, ... }: {
	users.users.skowriii = {
		isNormalUser = true;
		extraGroups = [
			"wheel"
			"video"
			"audio"
			"input"
			"networkmanager"
			config.services.silverbullet.group
		];
		shell = pkgs.bash;
	};
}
