{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tcpdump
    acpi
    dmidecode
    lshw
    lsof
    vim
    git
    jq
    zip
    unzip
    zed-editor
    gimp
    google-chrome
    zoom-us
    ngrok
    usbutils
    tmux
    eclipses.eclipse-sdk
    vscode
    miller
    ptyxis
    code-cursor
  ];

  users.extraUsers.wal = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };
  users.extraUsers.leona = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };
  users.extraUsers.bsmith = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };
  users.extraUsers.minecraft = {
     isNormalUser = true;
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
