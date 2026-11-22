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
		ncdu
		sops
		ugrep
		wget
	];
}
