{ pkgs, ... }:

{
	fonts.packages = with pkgs; [
		inter
		nerd-fonts.jetbrains-mono
		nerd-fonts._0xproto
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		noto-fonts-color-emoji
	];
}
