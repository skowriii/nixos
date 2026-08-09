{ pkgs, ... }:

{
	services.dnsmasq.enable = true;

	environment.systemPackages = with pkgs; [iproute2 libguestfs];

	virtualisation = {
		libvirtd = {
			enable = true;
			qemu.swtpm.enable = true;
		};
		spiceUSBRedirection.enable = true;
	};

	programs.virt-manager.enable = true;

	users.users.skowriii.extraGroups = ["libvirtd"];

	system.activationScripts.virtNetworkDefault = ''
		if [ ! -f /var/lib/nixos-once/virt-net-default ]; then
			mkdir -p /var/lib/nixos-once
			${pkgs.libvirt}/bin/virsh net-start default || true
			${pkgs.libvirt}/bin/virsh net-autostart default || true
			touch /var/lib/nixos-once/virt-net-default
		fi
	'';
}
