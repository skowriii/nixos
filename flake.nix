{
	inputs = {
		nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, ... }: {
		nixosConfigurations.skurwiii = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [./config/configuration.nix];
		};
	};
}
