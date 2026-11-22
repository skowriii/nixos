{ pkgs, ... }:

{
	programs = {
		bash.enable = true;
		nh.enable = true;
	};

	environment.systemPackages = with pkgs; [
		acpi
		acpica-tools
		btop
		cloudflared
		curl
		duf
		git
		lazygit
		ncdu
		sops
		ugrep
		wget
	];
}
