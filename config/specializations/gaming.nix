{ ... }:

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
				../home-manager.nix
				../systemd.nix
				../gaming.nix
				../extras/nbfc.nix
			];

			specializationType = "gaming";

			services.displayManager = {
				autoLogin = {
					enable = true;
					user = "skowriii";
				};
				defaultSession = "steam";
			};

			powerManagement.cpuFreqGovernor = "performance";

			documentation.enable = false;
		};
	};
}
