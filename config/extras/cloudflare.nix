{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; if config.modules.cloudflare then [wrangler cloudflared] else [];
}
