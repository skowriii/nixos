{ pkgs, ... }:

{
	environment.systemPackages = [pkgs.man-pages];

	documentation = {
		dev.enable = true;
		nixos = {
			includeAllModules = true;
			options.warningsAreErrors = false;
		};
	};
}
