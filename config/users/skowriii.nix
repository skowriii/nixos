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
		openssh.authorizedKeys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ3DcZ9cI8eBkc/4y2WI+5ySHd4UEN6u/7NskcyO42jl jakubskowron766@proton.me"
		];
	};
}
