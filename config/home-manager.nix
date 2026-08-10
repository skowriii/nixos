{ inputs, globals, ... }:

{
	imports = [inputs.home-manager.nixosModules.home-manager];

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		startAsUserService = true;
		extraSpecialArgs = { inherit inputs globals; };
		users.skowriii = ./users/skowriii/home.nix;
	};
}
