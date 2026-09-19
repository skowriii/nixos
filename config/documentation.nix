{ pkgs, ... }:

{
	environment.systemPackages = [pkgs.man-pages];

	documentation.nixos.enable = false;
}
