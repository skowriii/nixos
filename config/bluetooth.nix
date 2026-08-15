{ config, ... }:

{
	hardware.bluetooth.enable = config.modules.bluetooth;

	services.blueman.enable = config.modules.bluetooth;

	boot.extraModprobeConfig = if config.modules.bluetooth then "options bluetooth disable_ertm=Y" else "";
}
