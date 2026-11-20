{
	inputs.nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";

	outputs = inputs@{ self, nixpkgs, ... }: {
		nixosConfigurations.nixbob = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [./config/configuration.nix];
		};
	};
}
