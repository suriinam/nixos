{
  pkgs,
  videoDriver,
  hostname,
  browser,
  editor,
  terminal,
  terminalFileManager,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/video/${videoDriver}.nix # Enable gpu drivers defined in flake.nix
    ../../modules/hardware/drives

    ../common.nix
    ../../modules/scripts

    ../../modules/desktop/hyprland # Enable hyprland window manager

    ../../modules/programs/browser/firefox
    ../../modules/programs/terminal/kitty
    ../../modules/programs/editor/vscode
    ../../modules/programs/shell/bash
    ../../modules/programs/shell/zsh
    ../../modules/programs/media/discord
    ../../modules/programs/media/youtube-music
    ../../modules/programs/media/thunderbird
  ];

  # Home-manager config
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        gimp
      ];
    })
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [
  ];

  networking.hostName = hostname; # Set hostname defined in flake.nix
}
