{ pkgs, inputs, lib, ... }:

let
	hyprqt6engine = inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.hyprqt6engine.overrideAttrs (old: {
		buildInputs = old.buildInputs ++ [pkgs.kdePackages.kcolorscheme pkgs.kdePackages.kconfig];
	});
in {
	programs = {
		hyprland.enable = true;
		hyprlock.enable = true;
		thunar = {
			enable = true;
			plugins = with pkgs; [thunar-archive-plugin tumbler];
		};
		nm-applet.enable = true;
	};

	environment.systemPackages = with pkgs; [
		# Hyprland
		hypridle
		hyprpolkitagent
		hyprshot
		hyprshutdown
		hyprsunset
		hyprqt6engine

		quickshell
		unixodbc # for qmlls

		fuzzel # Application launcher

		inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # Browser

		# File browser related
		ffmpegthumbnailer
		kdePackages.ark
		xdg-utils

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
		kdePackages.frameworkintegration
		matugen
		nwg-look
		bibata-cursors
		kora-icon-theme
		darkly
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

	environment.variables = with pkgs; {
		GSETTINGS_SCHEMA_DIR =
			"${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}/glib-2.0/schemas";
		QT_PLUGIN_PATH = lib.concatStringsSep ":" [
			"$QT_PLUGIN_PATH"
			"${hyprqt6engine}/lib/qt-6"
		];
		NIXOS_OZONE_WL = "1";
	};

	qt.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-hyprland];
	};

	services = {
		dunst.enable = true;
		gvfs.enable = true;
		gnome.gnome-keyring.enable = true;
	};
}
