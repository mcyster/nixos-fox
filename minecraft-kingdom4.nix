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
  ];

  environment.systemPackages = with pkgs; [
    prismlauncher
    minecraft-server
  ];

  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    openFirewall = true;

    dataDir = "/home/minecraft/kingdom4";
    package = pkgs.minecraft-server;

    jvmOpts = "-Xms2G -Xmx6G -XX:+UseG1GC";

    serverProperties = {
      "server-port" = 25565;
      "motd" = "Kingdom4";
      "online-mode" = false; # LAN
      "level-name" = "world1";
      "view-distance" = 12;
      "enable-command-block" = true;
      "difficulty" = "normal";
    };
  };

  # Allow the service to use /home/minecraft/kingdom4
  systemd.services.minecraft-server.serviceConfig = {
    WorkingDirectory = lib.mkForce "/home/minecraft/kingdom4";
    ReadWritePaths   = lib.mkForce [ "/home/minecraft/kingdom4" ];
    ProtectHome      = lib.mkForce false;
    DynamicUser      = lib.mkForce false;
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}

