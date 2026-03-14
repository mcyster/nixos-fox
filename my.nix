{ config, pkgs, lib, ... }:

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

    direnv

    python3

    gimp
    google-chrome
    prismlauncher

    ngrok
    tmux
    miller

    eclipses.eclipse-sdk

    cursor-cli
    code-cursor
    ripgrep
    mdcat

    zoom-us
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  virtualisation.docker.enable = true;
  users.users.wal.extraGroups = [ "docker" ];

  programs.steam.enable = true;

  users.users.leona = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  security.sudo.extraRules = [
    {
      users = [ "wal" ];
      commands = [
        { command = "ALL"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];

  environment.variables.EDITOR = lib.mkForce "vim";
}
