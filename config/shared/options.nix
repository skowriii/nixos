{ lib, ... }:

{
	options.specializationType = lib.mkOption {
		description = "Indicates which, if any, specialization is currently running.";
		type = lib.types.enum [
			"none"
			"gaming"
		];
		default = "none";
	};
}
