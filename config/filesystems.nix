{ ... }:

{
	fileSystems = {
		"/".options = ["lazytime" "commit=60"];
		"/tmp" = {
			device = "/tmp";
			fsType = "tmpfs";
			options = ["defaults" "noatime" "mode=1777"];
			noCheck = true;
		};
	};
}
