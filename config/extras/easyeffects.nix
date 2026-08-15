{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; if config.modules.easyeffects then [
		calf
		easyeffects
		lsp-plugins
		mda_lv2
		zam-plugins
		zita-convolver
	] else [];
}
