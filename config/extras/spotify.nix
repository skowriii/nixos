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
			{
				src = "${pkgs.fetchFromGitHub {
					owner = "Resxt";
					repo = "Spicetify-Extensions";
					rev = "fb94b32511b74f791ddeb025aec0c77928d6bd60";
					hash = "sha256-SLu2+H5tdwPz0JrT61SuAx9uSW7Wfv2wLoA7d/AwmZQ=";
				}}/startup-page/dist";
				name = "startup-page.js";
			}
		];
	};

	environment.systemPackages = [pkgs.spotdl];
}
