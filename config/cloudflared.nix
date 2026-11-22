{ ... }:

{
	services.cloudflared = {
		enable = true;
		certificateFile = "/home/skowriii/.cloudflared/cert.pem";
		tunnels."6f98b44b-19a7-4684-bee5-0179ee18f700" = {
			default = "http_status:404";
			credentialsFile = "/home/skowriii/.cloudflared/6f98b44b-19a7-4684-bee5-0179ee18f700.json";
			ingress = {
				"ssh.skowriii.com" = "ssh://localhost:7032";
				"notes.skowriii.com" = "http://localhost:5117";
				"media.skowriii.com" = "http://localhost:8096";
			};
		};
	};
}
