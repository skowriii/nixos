{ pkgs, ... }:

{
	programs.bash.enable = true;

	environment.systemPackages = with pkgs; [
		acpi
		acpica-tools
		btop
		curl
		duf
		git
		ncdu
		sops
		ugrep
		wget
	];
}
