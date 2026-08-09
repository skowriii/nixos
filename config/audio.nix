{ pkgs, ... }:

{
	security.rtkit.enable = true;

	services = {
		pipewire = {
			enable = true;
			pulse.enable = true;
			alsa = {
				enable = true;
				support32Bit = true;
			};
			jack.enable = true;
			wireplumber.enable = true;
		};
	};

	environment.systemPackages = with pkgs; [
		audacity
		gst_all_1.gst-plugins-good
		kew
		pavucontrol
		picard
		playerctl
	];
}
