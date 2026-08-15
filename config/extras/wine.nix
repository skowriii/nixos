{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; if config.modules.wine then [lutris wine winetricks] else [];
}
