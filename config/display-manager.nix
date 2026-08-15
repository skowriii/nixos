{ config, ... }:

{
	services.displayManager.ly = if config.modules.displayManager then {
		enable = true;
		settings = {
			animation = "dur_file";
			battery_id = "BAT0";
			dur_file_path = "/personal/blackhole-smooth-240x67.dur";
			gameoflife_fg = "0x00FFFFFF";
			full_color = true;
		};
	} else {};
}
