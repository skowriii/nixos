{ ... }:

{
	hardware.bluetooth.enable = true;

	services.blueman.enable = true;

	boot.extraModprobeConfig = "options bluetooth disable_ertm=Y";
}
