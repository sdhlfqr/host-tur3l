{ pkgs, ... }: {
  # WSL
  wsl = {
    enable = true;
    defaultUser = "sayf";

    wslConf = {
      automount.enabled = true;
      automount.options = "metadata,uid=1000,gid=100,umask=022";
    };
  };

  # Users
  users.users.sayf = {
    isNormalUser = true;
    extraGroups = [ "docker" ];

    shell = pkgs.fish;
  };

  # Network
  networking.hostName = "tur3l";

  # Programs
  programs.ssh.startAgent = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    curl
  ];

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    tar
    gzip
    direnv
    curl
    wget
  ];

  # Virtualisation
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # NixOS
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.max-substitution-jobs = 64;
  nix.settings.http-connections = 64;

  # Garbage
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  system.stateVersion = "26.05";
}
