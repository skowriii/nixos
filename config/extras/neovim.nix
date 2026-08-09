{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		neovim
		luaPackages.tree-sitter-cli
		ripgrep
		gcc
		cmake
		gnumake
		nixd
	];
}
