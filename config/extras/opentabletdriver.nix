{ config, ... }:

{
	hardware.opentabletdriver = if config.modules.opentabletdriver then {
		enable = true;
		daemon.enable = true;
	} else {};
}
