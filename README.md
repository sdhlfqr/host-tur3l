# host-tur3l

NixOS on WSL configuration for host `tur3l` (software lab environment).

## Repository Structure

- `flake.nix`: System entry point defining the NixOS WSL flake and Home Manager configurations
- `config.nix`: NixOS system configuration (WSL integration, user environment, Docker, fish shell, system packages)
- `shell.nix`: Nix development shell with formatting and language tooling (`nixfmt`, `nil`)
- `Makefile`: System rebuild, update, and maintenance commands

## External Modules

- [config-sayf](https://github.com/sdhlfqr/config-sayf): Public user configuration and dotfiles
- `config-sayf-secrets`: Private user credentials and sensitive configurations

## Setup & Usage

### 1. Environment & Secrets

This configuration imports private modules which require a GitHub Personal Access Token (PAT) with repository read access.

Create a `.env` file in the repository root:

```bash
GITHUB_CONFIG_SAYF_SECRETS_TOKEN=your_token_here
```

Allow direnv to automatically export the environment variable:

```bash
direnv allow
```

### 2. Management Commands

Rebuild and activate configuration:

```bash
make switch
```

Update inputs and rebuild:

```bash
make refresh
```

Clean up old generations and optimize Nix store:

```bash
make clean
```
