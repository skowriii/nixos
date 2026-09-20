{ inputs, pkgs, ... }:

{
	programs = {
		hyprland.enable = true;
		hyprlock.enable = true;
		thunar = {
			enable = true;
			plugins = with pkgs; [thunar-archive-plugin tumbler];
		};
		nm-applet.enable = true;
	};

	environment = {
		systemPackages = with pkgs; [
			hypridle
			hyprpolkitagent
			hyprshot
			hyprshutdown
			hyprsunset

			quickshell

			fuzzel

			# (pkgs.buildFHSEnv {
			# 	name = "zen";
			# 	targetPkgs = pkgs: (with pkgs; [
			# 		ffmpeg-full
			# 		libva
			# 		mesa
			# 		libglvnd
			# 		alsa-lib
			# 		pipewire
			# 	]);
			# 	runScript = "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zen";
			# })
			inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

			# File browser related
			ffmpegthumbnailer
			kdePackages.ark
			xdg-utils
			udiskie

			# Images
			eog
			gimp
			inkscape

			# Videos
			mpv
			# vlc

			gnome-disk-utility # Disk manager

			# Theming
			glib
			gsettings-desktop-schemas
			adw-gtk3
			kdePackages.frameworkintegration # for darkly
			matugen
			nwg-look
			kora-icon-theme
			qt5.qtwayland
			qt6.qtwayland

			pluma # Notepad

			# Screenshots
			grim
			slurp

			# Clipboard
			copyq
			wl-clipboard

			# Wallpapers
			awww
			waypaper

			# Torrent client
			qbittorrent
		];
		variables = with pkgs; {
				GSETTINGS_SCHEMA_DIR =
					"${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}/glib-2.0/schemas";
				NIXOS_OZONE_WL = "1";
		};
	};

	qt.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = [pkgs.xdg-desktop-portal-gtk];
	};

	services = {
		dunst.enable = true;
		gvfs.enable = true;
		gnome.gnome-keyring.enable = true;
	};

	fonts.packages = with pkgs; [
		inter
		nerd-fonts.jetbrains-mono
		nerd-fonts._0xproto
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		noto-fonts-color-emoji
	];
}
