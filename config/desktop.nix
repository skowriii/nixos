{ pkgs, inputs, ... }:

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

	environment.systemPackages = with pkgs; [
		hypridle
		hyprpolkitagent
		hyprshot
		hyprshutdown
		hyprsunset

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
		kdePackages.frameworkintegration # for darkly
		matugen
		nwg-look
		bibata-cursors
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

	environment.variables = with pkgs; {
		GSETTINGS_SCHEMA_DIR =
			"${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}/glib-2.0/schemas";
		NIXOS_OZONE_WL = "1";
	};

	qt.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [xdg-desktop-portal-hyprland xdg-desktop-portal-gtk];
	};

	services = {
		dunst.enable = true;
		gvfs.enable = true;
		gnome.gnome-keyring.enable = true;
	};
}
