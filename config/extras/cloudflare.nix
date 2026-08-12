{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [wrangler cloudflared];
}
