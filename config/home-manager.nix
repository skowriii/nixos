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

	# ly launches Hyprland into session-N.scope, so nothing ever reads
	# hm-session-vars.sh: not a login shell, and not systemd's environment.d
	# either (that only covers units under user@.service). Everything in
	# home.sessionVariables - QT_QPA_PLATFORMTHEME included - was being dropped.
	# /etc/set-environment does reach the session, so pull the file in from there.
	environment.extraInit = ''
		if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
			. "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
		fi
	'';
}
