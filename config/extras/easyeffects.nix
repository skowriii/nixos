{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [ calf easyeffects lsp-plugins mda_lv2 zam-plugins zita-convolver ];
}
