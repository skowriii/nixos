{ config, pkgs, ... }:

{
	services.dnsmasq.enable = config.modules.virtualization;

	environment.systemPackages = with pkgs; if config.modules.virtualization then [iproute2 libguestfs] else [];

	virtualisation = if config.modules.virtualization then {
		libvirtd = {
			enable = true;
			qemu.swtpm.enable = true;
		};
		spiceUSBRedirection.enable = true;
	} else {};

	programs.virt-manager.enable = config.modules.virtualization;

	users.users.skowriii.extraGroups = if config.modules.virtualization then ["libvirtd"] else [];

	system.activationScripts.virtNetworkDefault = 
		if config.modules.virtualization then
			''
				if [ ! -f /var/lib/nixos-once/virt-net-default ]; then
					mkdir -p /var/lib/nixos-once
					${pkgs.libvirt}/bin/virsh net-start default || true
					${pkgs.libvirt}/bin/virsh net-autostart default || true
					touch /var/lib/nixos-once/virt-net-default
				fi
			''
		else "";
}
