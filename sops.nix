{ inputs, config, ... }:

{
	imports = [inputs.sops-nix.nixosModules.sops];

	sops = {
		defaultSopsFile = ./secrets/secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/skowriii/.config/sops/age/keys.txt";
		secrets = {
			freewifi_psk.key = "networkmanager_env/FREEWIFI_PSK";
			mim-komputer_network_psk.key = "networkmanager_env/MIM_KOMPUTER_NETWORK_PSK";
		};
		templates = {
			"networkmanager.env".content = ''
				FREEWIFI_PSK=${config.sops.placeholder.freewifi_psk}
				MIM_KOMPUTER_NETWORK_PSK=${config.sops.placeholder.mim-komputer_network_psk}
			'';
		};
	};
}
