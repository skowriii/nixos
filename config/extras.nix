{ config, pkgs, lib, globals, inputs, ... }:

{
	imports = [inputs.spicetify-nix.nixosModules.spicetify];

	environment = {
		etc."nbfc/nbfc.json" = {
			enable = config.modules.nbfc;
			text = builtins.toJSON { SelectedConfigId = globals.nbfcModel; };
		};
		systemPackages = with pkgs; []
			++ lib.optionals config.modules.cloudflare
				[wrangler cloudflared]
			++ lib.optionals config.modules.easyeffects
				[calf easyeffects lsp-plugins mda_lv2 zam-plugins zita-convolver]
			++ lib.optionals config.modules.nbfc
				[nbfc-linux]
			++ lib.optionals config.modules.neovim
				[neovim luaPackages.tree-sitter-cli ripgrep gcc cmake gnumake nixd]
			++ lib.optionals config.modules.spotify
				[spotdl]
			++ lib.optionals config.modules.tmux
				[smug]
			++ lib.optionals config.modules.virtualization
				[iproute2 libguestfs]
			++ lib.optionals config.modules.wine
				[lutris wineWow64Packages.stable winetricks];
	};

	users.users.skowriii.extraGroups = []
		++ lib.optionals config.modules.docker
			["docker"]
		++ lib.optionals config.modules.virtualization
			["libvirtd"];

	virtualisation = {
		docker = lib.mkIf config.modules.docker {
			enable = true;
			enableOnBoot = true;
			autoPrune = {
				enable = true;
				persistent = true;
			};
			extraPackages = [pkgs.docker-compose];
		} ;
		libvirtd = lib.mkIf config.modules.virtualization {
			enable = true;
			qemu.swtpm.enable = true;
		} ;
		spiceUSBRedirection.enable = config.modules.virtualization;
	};

	systemd.services.nbfc_service = lib.mkIf config.modules.nbfc {
		description = "NoteBook FanControl service";
		path = [pkgs.kmod];
		serviceConfig = {
			Type = "simple";
			# Drop any saved fixed fan speed. Without this a manual "nbfc set -s"
			# survives reboots and silently disables the profile's fan curve.
			ExecStartPre = "${pkgs.coreutils}/bin/rm -f /var/lib/nbfc/state.json";
			ExecStart = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file /etc/nbfc/nbfc.json";
			Restart = "on-failure";
			RestartSec = 5;
			StateDirectory = "nbfc";
		};
		startLimitIntervalSec = 60;
		wantedBy = ["multi-user.target"];
	};

	programs = {
		obs-studio = lib.mkIf config.modules.obs {
			enable = true;
			plugins = with pkgs.obs-studio-plugins; [obs-pipewire-audio-capture obs-vaapi];
		};
		spicetify = lib.mkIf config.modules.spotify {
			enable = true;
			enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
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
		tmux.enable = config.modules.tmux;
		virt-manager.enable = config.modules.virtualization;
	};

	hardware.opentabletdriver = lib.mkIf config.modules.opentabletdriver {
		enable = true;
		daemon.enable = true;
	};

	services.dnsmasq.enable = config.modules.virtualization;

	system.activationScripts.virtNetworkDefault = lib.mkIf config.modules.virtualization
		''
			if [ ! -f /var/lib/nixos-once/virt-net-default ]; then
				mkdir -p /var/lib/nixos-once
				${pkgs.libvirt}/bin/virsh net-start default || true
				${pkgs.libvirt}/bin/virsh net-autostart default || true
				touch /var/lib/nixos-once/virt-net-default
			fi
		'';
}
