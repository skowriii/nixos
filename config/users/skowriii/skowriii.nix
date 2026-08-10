{ pkgs, ... }: {
	users.users.skowriii = {
		isNormalUser = true;
		extraGroups = ["wheel" "video" "audio" "input" "networkmanager"];
		shell = pkgs.zsh;
	};
}
