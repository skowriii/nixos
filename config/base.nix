{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [udiskie acpi acpica-tools];

	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		nix-ld.enable = true;
	};

	services.tlp.enable = true;

	powerManagement.cpuFreqGovernor = "schedutil";
}
