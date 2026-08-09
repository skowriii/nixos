{ pkgs, ... }:

{
	programs.npm.enable = true;

	environment.systemPackages = with pkgs; [
		# cmake
		# gdb
		gitleaks
		osv-scanner
		# zig
		claude-code
		python3
		semgrep
	];
}
