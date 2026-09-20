.PHONY: all switch refresh clean

FLAKE ?= .#tur3l

all: switch

check-token:
ifndef GITHUB_CONFIG_SAYF_SECRETS_TOKEN
	$(error GITHUB_CONFIG_SAYF_SECRETS_TOKEN is not exported in your current shell. Ensure direnv is allowed.)
endif

switch: check-token
	@sudo nixos-rebuild switch --flake $(FLAKE) --option access-tokens "github.com=$(GITHUB_CONFIG_SAYF_SECRETS_TOKEN)"

refresh: check-token
	@sudo nixos-rebuild switch --flake $(FLAKE) --option access-tokens "github.com=$(GITHUB_CONFIG_SAYF_SECRETS_TOKEN)" --refresh

clean:
	@rm -f result
	@sudo nix-collect-garbage -d
	@sudo nix-store --optimize
