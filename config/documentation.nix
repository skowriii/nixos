{ pkgs, ... }:

{
	environment.systemPackages = [pkgs.man-pages];

	documentation = {
		dev.enable = true;
		man.cache = {
			enable = true;
			generateAtRuntime = true;
		};
		nixos = {
			includeAllModules = true;
			options.warningsAreErrors = false;
		};
	};
}
