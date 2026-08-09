{ pkgs, inputs, ... }:

let
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
	imports = [inputs.spicetify-nix.nixosModules.spicetify];

	programs.spicetify = {
		enable = true;
		enabledExtensions = with spicePkgs.extensions; [
			adblock
			fullAppDisplay
			volumePercentage
		];
	};

	environment.systemPackages = [pkgs.spotdl];
}
