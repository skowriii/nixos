{ inputs, config, ... }:

{
	imports = [inputs.sops-nix.nixosModules.sops];

	sops = {
		defaultSopsFile = ./secrets/secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/var/lib/sops-nix/keys.txt";
		secrets = {
			networkmanager_freewifi_psk.key = "networkmanager_env/FREEWIFI_PSK";
			silverbullet_sb_user.key = "silverbullet_env/SB_USER";
			spotdl_client_id.key = "spotdl_env/CLIENT_ID";
			spotdl_client_secret.key = "spotdl_env/CLIENT_SECRET";
		};
		templates = {
			"networkmanager.env".content = "FREEWIFI_PSK=${config.sops.placeholder.networkmanager_freewifi_psk}";
			"silverbullet.env".content = ''
				SB_METRICS_PORT=5118
				SB_USER=${config.sops.placeholder.silverbullet_sb_user};
			'';
			"spotdl.env" = {
				owner = "skowriii";
				group = "users";
				content = ''
					SPOTDL_CLIENT_ID=${config.sops.placeholder.spotdl_client_id}
					SPOTDL_CLIENT_SECRET=${config.sops.placeholder.spotdl_client_secret}
				'';
			};
		};
	};
}
