{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# cmake
		# gdb
		gitleaks
		osv-scanner
		# zig
		python3
		semgrep
	];
}
