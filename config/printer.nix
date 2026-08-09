{ pkgs, ... }:

{
	services.printing = {
		enable = true;
		cups-pdf.enable = true;
		drivers = with pkgs; [gutenprint hplip splix];
	};

	programs.system-config-printer.enable = true;
}
