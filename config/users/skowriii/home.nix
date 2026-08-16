{ config, osConfig, pkgs, globals, ... }:

let
	qtCommonSettings = {
		Appearance = {
			icon_theme = "kora";
			standard_dialogs = "xdgdesktopportal";
			style = "Darkly";
			color_scheme_path = "~/.local/share/color-schemes/Matugen.colors";
			custom_palette = true;
		};
		Fonts.general = "\"Inter,12\"";
	};
in
{
	home = {
		username = "skowriii";
		homeDirectory = "/home/skowriii";
		stateVersion = "26.05";
		activation = {
			spotifyPrefs =
				if osConfig.modules.spotify then
					config.lib.dag.entryAfter ["writeBoundary"] ''
						mkdir -p "$HOME/.config/spotify"

						if ! grep -q "^storage.size=4096$" "$HOME/.config/spotify/prefs" 2>/dev/null; then
							echo "storage.size=4096" >> "$HOME/.config/spotify/prefs"
						fi
					''
				else "";
		};
		file = {
			".gnupg".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/.gnupg";
			".ssh".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/.ssh";
			dotfiles.source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/dotfiles";
			Projects.source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/Projects";
			wallpapers.source =
				config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/wallpapers";
			".gitconfig".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.gitconfig";
			".local/bin/change-brightness".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.local/bin/change-brightness";
			".local/bin/pwall".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/Projects/Tools/Bash/PauseWallpaper/pwall";
			".zen".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/.zen";
			".task".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/.task";
			".zsh".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.zsh";
			".zshrc".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.zshrc";
			".zshenv".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.zshenv";
			".local/bin/sscli".source =
				config.lib.file.mkOutOfStoreSymlink
					"${globals.rootDirectory}/Projects/Applications/QML/ss/Scripts/sscli/sscli";
			".tmux.conf" = {
				enable = osConfig.modules.tmux;
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.tmux.conf";
			};
			".password-store".source =
				config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/.password-store";
		};
	};

	xdg = {
		configFile = {
			fuzzel = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/fuzzel";
				force = true;
			};
			hypr = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/hypr";
				force = true;
			};
			matugen = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/matugen";
				force = true;
			};
			mpv = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/mpv";
				force = true;
			};
			waypaper = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/waypaper";
				force = true;
			};
			btop = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/btop";
				force = true;
			};
			ncdu = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/ncdu";
				force = true;
			};
			foot = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/foot";
				force = true;
			};
			bleachbit = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/bleachbit";
				force = true;
			};
			"quickshell/ss" = {
				source = config.lib.file.mkOutOfStoreSymlink "${globals.rootDirectory}/Projects/Applications/QML/ss";
				force = true;
			};
			nvim = {
				enable = osConfig.modules.neovim;
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/nvim";
				force = true;
			};
			easyeffects = {
				enable = osConfig.modules.easyeffects;
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/easyeffects";
				force = true;
			};
			tmux = {
				enable = osConfig.modules.tmux;
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/tmux";
				force = true;
			};
			smug = {
				enable = osConfig.modules.tmux;
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/smug";
				force = true;
			};
			"OpenTabletDriver/Plugins" = {
				enable = osConfig.modules.opentabletdriver;
				source =
					config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/OpenTabletDriver/Plugins";
				force = true;
			};
			"OpenTabletDriver/Presets" = {
				enable = osConfig.modules.opentabletdriver;
				source =
					config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/OpenTabletDriver/Presets";
				force = true;
			};
			"OpenTabletDriver/settings.json" = {
				enable = osConfig.modules.opentabletdriver;
				source =
					config.lib.file.mkOutOfStoreSymlink
					"${globals.dotfilesDirectory}/home/.config/OpenTabletDriver/settings.json";
			};
			spotdl = {
				enable = osConfig.modules.spotify;
				source = config.lib.file.mkOutOfStoreSymlink "${globals.dotfilesDirectory}/home/.config/spotdl";
				force = true;
			};
		};
		userDirs = {
			enable = true;
			createDirectories = true;
			package = pkgs.xdg-user-dirs-gtk;
		};
	};

	systemd.user = {
		services.change-brightness = {
			Unit.Description = "Change brightness at 8 AM and 10 PM every day";
			Service = {
				Type = "oneshot";
				ExecStart = "%h/.local/bin/change-brightness";
			};
		};
		timers.change-brightness = {
			Unit = {
				Description = "Change brightness at 8 AM and 10 PM every day";
				After = ["multi-user.target"];
			};
			Timer = {
				OnCalendar = ["*-*-* 8:00" "*-*-* 22:00"];
				AccuracySec = "1us";
				Persistent = true;
				Unit = "change-brightness.service";
			};
			Install.WantedBy = ["timers.target"];
		};
	};

	gtk = {
		enable = true;
		theme = {
			package = pkgs.adw-gtk3;
			name = "adw-gtk3-dark";
		};
		iconTheme = {
			package = pkgs.kora-icon-theme;
			name = "kora";
		};
		font = {
			name = "Inter";
			size = 12;
		};
		gtk3.extraCss = "@import \"colors.css\";";
		gtk4.extraCss =
			"@import url(\"${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0/gtk.css\");\n@import \"colors.css\";";
		colorScheme = "dark";
	};

	qt = {
		enable = true;
		platformTheme.name = "qtct";
		qt5ctSettings = qtCommonSettings;
		qt6ctSettings = qtCommonSettings;
		style.package = pkgs.darkly;
		# style.name = "darkly";
	};
}
