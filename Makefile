FLAKE ?= .
NIXOS_REBUILD = nix shell nixpkgs#nixos-rebuild -c nixos-rebuild
CMD ?= switch   # nixos-rebuild action (switch, boot, dry-run, test)

# Define hosts here: flakeOutput targetUser@targetHost buildHost
AIKEN = aiken ceadmin@aiken aiken
ADA   = ada ceadmin@ada ada

aiken:
	$(NIXOS_REBUILD) $(CMD) --flake $(FLAKE)#$(word 1,$(AIKEN)) \
		--target-host $(word 2,$(AIKEN)) \
		--build-host $(word 3,$(AIKEN)) \
		--use-remote-sudo

ada:
	$(NIXOS_REBUILD) $(CMD) --flake $(FLAKE)#$(word 1,$(ADA)) \
		--target-host $(word 2,$(ADA)) \
		--build-host $(word 3,$(ADA)) \
		--use-remote-sudo
