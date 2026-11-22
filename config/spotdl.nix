{ pkgs, config, ... }:

{
	environment.systemPackages = with pkgs; [spotdl ffmpeg];

	systemd.user = {
		services.sync-favorites = {
			enable = true;
			description = "Saved playlist sync using SpotDL";
			after = ["multi-user.target" "network-online.target"];
			serviceConfig = {
				Type = "oneshot";
				EnvironmentFile = config.sops.templates."spotdl.env".path;
				ExecStart = pkgs.writeShellScript "sync-favorites" ''
					SF_FAVORITES_LOCATION="/mnt/music/Favorites"
					SF_SAVED_FILE="saved.m3u8";

					function log()
					{
						echo "[sync-favorites] $@"
					}

					if [[ ! -d "$SF_FAVORITES_LOCATION" ]]; then
						log "\"''${SF_FAVORITES_LOCATION}\" doesn't exist! creating..."
						mkdir "$SF_FAVORITES_LOCATION"
					fi

					log "moving into \"''${SF_FAVORITES_LOCATION}\"..."
					cd "$SF_FAVORITES_LOCATION"

					if [[ -f "$SF_SAVED_FILE" ]]; then
						log "backing up \"''${SF_SAVED_FILE}\"..."
						mv "$SF_SAVED_FILE" "''${SF_SAVED_FILE}.bak"
					fi

					log "syncing saved..."
					if ${pkgs.spotdl}/bin/spotdl --client-id "$SPOTDL_CLIENT_ID" \
						--client-secret "$SPOTDL_CLIENT_SECRET" \
						--user-auth \
						--simple-tui \
						--threads 1 \
						--save-file saved.spotdl \
						--preload \
						--m3u "$SF_SAVED_FILE" \
						--playlist-retain-track-cover \
						--generate-lrc \
						--create-skip-file \
						--respect-skip-file \
						sync saved
					then
						log "syncing successful!"

						if [[ -f "''${SF_SAVED_FILE}.bak" ]]; then
							log "removing \"''${SF_SAVED_FILE}.bak\"..."
							rm "''${SF_SAVED_FILE}.bak"
						fi

						exit 0
					else
						log "syncing failed!"

						if [[ -f "''${SF_SAVED_FILE}.bak" ]]; then
							log "restoring \"''${SF_SAVED_FILE}\"..."
							mv "''${SF_SAVED_FILE}.bak" "$SF_SAVED_FILE"
						fi

						exit 1
					fi
				'';
			};
		};
		timers.sync-favorites = {
			enable = true;
			description = "Timer for Saved playlist sync using SpotDL";
			after = ["multi-user.target" "network-online.target"];
			timerConfig = {
				OnCalendar = "weekly";
				Persistent = true;
				AccuracySec = "1us";
				Unit = "sync-favorites.service";
			};
			wantedBy = ["timers.target"];
		};
		tmpfiles.settings."10-spotdl" = {
			"/home/skowriii/.config/spotdl".d = {
				user = "skowriii";
				group = "users";
				mode = "0755";
				age = "-";
			};
			"/home/skowriii/.config/spotdl/config.json".F = {
				user = "skowriii";
				group = "users";
				mode = "0644";
				age = "-";
				argument = builtins.toJSON {
					client_id = null;
					client_secret = null;
					auth_token = null;
					user_auth = false;
					headless = false;
					cache_path = "/home/skowriii/.config/spotdl/.spotipy";
					no_cache = false;
					max_retries = 3;
					use_cache_file = false;
					audio_providers = ["youtube-music" "youtube" "soundcloud" "bandcamp" "piped"];
					lyrics_providers = ["synced"];
					genius_token = null;
					playlist_numbering = false;
					playlist_retain_track_covers = false;
					scan_for_songs = false;
					m3u = false;
					output = "{artists} - {title}.{output-ext}";
					overwrite = "skip";
					search_query = null;
					ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg";
					bitrate = "128k";
					ffmpeg_args = null;
					format = "flac";
					save_file = null;
					filter_results = true;
					album_type = null;
					threads = 4;
					cookie_file = null;
					restrict = null;
					print_errors = false;
					sponsor_block = false;
					preload = false;
					archive = null;
					load_config = true;
					log_level = "INFO";
					simple_tui = false;
					fetch_albums = false;
					id3_separator = "/";
					ytm_data = false;
					add_unavailable = false;
					generate_lrc = false;
					force_update_metadata = false;
					only_verified_results = false;
					sync_without_deleting = false;
					max_filename_length = null;
					yt_dlp_args = null;
					detect_formats = null;
					save_errors = null;
					ignore_albums = null;
					proxy = null;
					skip_explicit = false;
					log_format = null;
					redownload = false;
					skip_album_art = false;
					create_skip_file = false;
					respect_skip_file = false;
					sync_remove_lrc = false;
					web_use_output_dir = false;
					port = 8800;
					host = "localhost";
					keep_alive = false;
					enable_tls = false;
					key_file = null;
					cert_file = null;
					ca_file = null;
					allowed_origins = null;
					keep_sessions = false;
					force_update_gui = false;
					web_gui_repo = null;
					web_gui_location = null;
				};
			};
		};
	};
}
