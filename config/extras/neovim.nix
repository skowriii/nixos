{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; if config.modules.neovim then [
		neovim
		luaPackages.tree-sitter-cli
		ripgrep
		gcc
		cmake
		gnumake
		nixd
	] else [];
}
