# /etc/nixos/minecraft-kingdom4.nix
{ config, pkgs, lib, ... }:

{
  users.groups.minecraft = {};

  users.users.minecraft = {
    isNormalUser = lib.mkForce true;
    isSystemUser = lib.mkForce false;
    home        = lib.mkForce "/home/minecraft";
    createHome  = lib.mkForce true;
    group       = lib.mkForce "minecraft";
  };

  systemd.tmpfiles.rules = [
    "d /home/minecraft 0750 minecraft minecraft -"
    "d /home/minecraft/kingdom4 0750 minecraft minecraft -"
    "d /home/minecraft/kingdom4/paper 0750 minecraft minecraft -"
  ];

  environment.systemPackages = with pkgs; [
    prismlauncher
    minecraft-server
  ];

  services.minecraft-server = {
    enable       = true;
    eula         = true;
    declarative  = true;
    openFirewall = true;

    # still use kingdom4 as the main data dir
    dataDir = "/home/minecraft/kingdom4";

    # package is effectively unused once we override ExecStart,
    # but we keep it for defaults / future use
    package = pkgs.minecraft-server;

    jvmOpts = "-Xms2G -Xmx6G -XX:+UseG1GC";

    serverProperties = {
      "server-port"           = 25565;
      "motd"                  = "Kingdom4";
      "online-mode"           = false; # LAN
      "level-name"            = "world1";
      "view-distance"         = 10;
      "enable-command-block"  = true;
      "difficulty"            = "normal";
    };
  };

  # Override the systemd service to use Paper
  systemd.services.minecraft-server.serviceConfig = {
    # run the server from the Paper directory
    WorkingDirectory = lib.mkForce "/home/minecraft/kingdom4";

    # allow writing to the whole kingdom4 tree
    ReadWritePaths   = lib.mkForce [ "/home/minecraft/kingdom4" ];
    ProtectHome      = lib.mkForce false;
    DynamicUser      = lib.mkForce false;

    # Replace ExecStart with our Paper command.
    # The empty string resets previous ExecStart entries.
    ExecStart = lib.mkForce [
      ""
      "${pkgs.jre_headless}/bin/java -Xms2G -Xmx4G -jar /home/minecraft/kingdom4/paper/paper-1.21.10.jar nogui"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 24454 ];

  systemd.timers.minecraft-server-start = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 18:00:00";
      Persistent = true;
    };
  };

  systemd.services.minecraft-server-start = {
    script = ''
      ${pkgs.systemd}/bin/systemctl start minecraft-server.service
    '';
  };

  systemd.timers.minecraft-server-stop = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 21:30:00";
      Persistent = true;
    };
  };
  
  systemd.services.minecraft-server-stop = {
    script = ''
      ${pkgs.systemd}/bin/systemctl stop minecraft-server.service
    '';
  };
}

