{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [udiskie acpi acpica-tools];

	programs = {
		nh = {
			enable = true;
			clean = {
				enable = true;
				dates = "weekly";
				extraArgs = "--keep 3";
			};
		};
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		nix-ld.enable = true;
	};

	services.tlp.enable = true;

	powerManagement.cpuFreqGovernor = "schedutil";
}
