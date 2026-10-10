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

	# hm-session-vars.sh is not read by anything, which causes certain things like
	# icons and Qt themes to not apply correctly or at all. We're sourcing it in
	# /etc/set-environment since that is actually read which fixes the problem.
	environment.extraInit = ''
		if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
			. "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
		fi
	'';
}
