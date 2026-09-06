{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [udiskie acpi acpica-tools];

	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

	services.tlp.enable = true;

	powerManagement.cpuFreqGovernor = "schedutil";
}
