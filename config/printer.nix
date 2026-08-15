{ config, pkgs, ... }:

{
	services.printing = if config.modules.printer then {
		enable = true;
		cups-pdf.enable = true;
		drivers = with pkgs; [gutenprint hplip splix];
	} else {};

	programs.system-config-printer.enable = config.modules.printer;
}
