{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; if config.modules.wine then [
		lutris
		wineWow64Packages.stable
		winetricks
	] else [];
}
