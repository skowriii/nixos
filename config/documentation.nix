{ pkgs, ... }:

{
	environment.systemPackages = [pkgs.man-pages];

	documentation = {
		dev.enable = true;
		nixos = {
			includeAllModules = true;
			options.warningsAreErrors = false;
		};
	};

	system.activationScripts.manDBCache.text = ''
		NEW_HASH=$(readlink -f /run/current-system/sw/share/man 2>/dev/null | \
			${pkgs.coreutils}/bin/sha256sum | \
			cut -d' ' -f1)
		HASH_FILE=/var/lib/mandb-cache-hash
		OLD_HASH=$(cat "$HASH_FILE" 2>/dev/null || echo "")

		if [ "$NEW_HASH" != "$OLD_HASH" ]; then
			echo "Package set changed, regenerating man-db cache..."
			${pkgs.man-db}/bin/mandb --quiet || echo "man-db cache regeneration failed!"
			mkdir -p /var/lib
			echo "$NEW_HASH" > "$HASH_FILE"
		fi
	'';
}
