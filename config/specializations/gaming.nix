{ pkgs, ... }:

{
	specialisation.gaming = {
		inheritParentConfig = false;

		configuration = {
			imports = [
				../hardware-configuration.nix
				../filesystems.nix
				../shared/common.nix
				../boot.nix
				../networkmanager.nix
				../audio.nix
				../bluetooth.nix
				../display-manager.nix
				../users/skowriii/skowriii.nix
				../systemd.nix
				../gaming.nix
				../extras/nbfc.nix
			];

			specializationType = "gaming";

			programs.niri.enable = true;

			environment.systemPackages = [pkgs.xwayland-satellite];

			services.displayManager = {
				autoLogin = {
					enable = true;
					user = "skowriii";
				};
				defaultSession = "niri";
			};

			powerManagement.cpuFreqGovernor = "performance";

			documentation.enable = false;
		};
	};
}
