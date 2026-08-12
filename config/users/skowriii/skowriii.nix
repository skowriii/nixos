{ config, pkgs, ... }: {
	users.users.skowriii = {
		isNormalUser = true;
		extraGroups = ["wheel" "video" "audio" "input" "networkmanager"];
		shell = if config.specializationType == "none" then pkgs.zsh else pkgs.bash;
	};
}
