{ ... }:

{
	specialisation.gaming = {
		inheritParentConfig = false;

		configuration = { pkgs, ... }: {
			imports = [
				../hardware-configuration.nix
				../filesystems.nix
				../boot.nix
				../networkmanager.nix
				../audio.nix
				../bluetooth.nix
				../display-manager.nix
				../users/skowriii.nix
				../home-manager.nix
				../systemd.nix
				../gaming.nix
			];

			nixpkgs.config.allowUnfree = true;

			networking.hostName = "nixbob";

			services = {
				displayManager = {
					autoLogin = {
						enable = true;
						user = "skowriii";
					};
					defaultSession = "steam";
				};
				nohang.enable = true;
				irqbalance.enable = true;
				libinput.enable = true;
				zram-generator = {
					enable = true;
					settings.zram0 = {
						zram-size = "ram";
						compression-algorithm = "zstd";
					};
				};
			};

			hardware = {
				graphics = {
					enable = true;
					enable32Bit = true;
				};
				amdgpu.overdrive.enable = true;
			};

			environment.systemPackages = [pkgs.nbfc-linux];

			programs.zsh.enable = true;

			powerManagement.cpuFreqGovernor = "performance";

			systemd.oomd.enable = false;

			boot.kernel.sysctl = {
				"vm.swappiness" = 130;
				"vm.page-cluster" = 0;
			};

			documentation.enable = false;

			time.timeZone = "Europe/Warsaw";

			i18n.defaultLocale = "pl_PL.UTF-8";

			console = {
				enable = true;
				font = "lat2-16";
				keyMap = "pl";
			};

			system.stateVersion = "26.05";
		};
	};
}
