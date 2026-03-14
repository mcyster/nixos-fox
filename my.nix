{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tcpdump
    acpi
    dmidecode
    pciutils
    lshw
    lsof
    vim
    git
    jq
    zip
    unzip
    usbutils

    python3 

    gimp
    google-chrome

    ngrok
    tmux
    miller
    docker

    zoom-us

    eclipses.eclipse-sdk

    # codex

    # cursor
    cursor-cli
    code-cursor
    ripgrep
    mdcat
  ];

  virtualisation.docker.enable = true;
  users.users.wal.extraGroups = [ "docker" ];

  programs.steam.enable = true;

  users.extraUsers.wal = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };
  users.extraUsers.leona = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };

  security.sudo.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "wal" ];
      commands = [
        { command = "ALL"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];

  environment.variables.EDITOR = pkgs.lib.mkOverride 0 "vim";
  #environment.variables.BROWSER = pkgs.lib.mkOverride 0 "google-chrome";
}
