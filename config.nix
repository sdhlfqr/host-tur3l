{ pkgs, ... }: {
  # WSL
  wsl = {
    enable = true;
    defaultUser = "sayf";
  };

  # Users
  users.users.sayf = {
    isNormalUser = true;
    extraGroups = [ "docker" ];
  };

  # Host
  networking.hostName = "tur3l";

  # Programs
  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [
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

	# 
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "26.05";
}
