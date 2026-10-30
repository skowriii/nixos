let
	rootDirectory = "/personal";
	dotfilesDirectory = "${rootDirectory}/dotfiles";
	nbfcModel = "HP ProBook 650 G2";
	cacheUrl = "https://releases.nixos.org/nixos/unstable-small/nixos-26.11pre1098711.c53532a93865/nixexprs.tar.xz";
	cacheHash = "sha256:1m8277kw4k04z0qh3qksbk2zvg771rsj639ln7avf5k7ay6gb8r4";
	getFromCache = { package, pkgs, url ? cacheUrl, hash ? cacheHash }:
		(import (fetchTarball {
			url = url;
			sha256 = hash;
		}) { system = pkgs.stdenv.hostPlatform.system; }).${package};
in
{ inherit rootDirectory dotfilesDirectory nbfcModel cacheUrl cacheHash getFromCache; }
