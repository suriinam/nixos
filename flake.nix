{
  description = "A simple flake for an atomic system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    thunderbird-catppuccin = {
      url = "github:catppuccin/thunderbird";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    settings = {
      # User configuration
      username = "marius"; # automatically set with install.sh and live-install.sh
      editor = "vscode"; # nixvim, vscode, nvchad, neovim, emacs (WIP)
      browser = "firefox"; # firefox, floorp, zen
      terminal = "kitty"; # kitty, alacritty, wezterm
      sddmTheme = "purple_leaves"; # astronaut, black_hole, purple_leaves, jake_the_dog, hyprland_kath
      wallpaper = "kurzgesagt"; # see modules/themes/wallpapers

      # System configuration
      videoDriver = "nvidia"; # CHOOSE YOUR GPU DRIVERS (nvidia, amdgpu or intel)
      hostname = "NixOS"; # CHOOSE A HOSTNAME HERE
      locale = "en_GB.UTF-8"; # CHOOSE YOUR LOCALE
      timezone = "Europe/Paris"; # CHOOSE YOUR TIMEZONE
      kbdLayout = "gb"; # CHOOSE YOUR KEYBOARD LAYOUT
      kbdVariant = "extd"; # CHOOSE YOUR KEYBOARD VARIANT (Can leave empty)
      consoleKeymap = "uk"; # CHOOSE YOUR CONSOLE KEYMAP (Affects the tty?)
    };

    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    templates = import ./dev-shells;
    overlays = import ./overlays {inherit inputs settings;};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    nixosConfigurations = {
      Default = nixpkgs.lib.nixosSystem {
        system = forAllSystems (system: system);
        specialArgs = {inherit self inputs outputs;} // settings;
        modules = [./hosts/Default/configuration.nix];
      };
    };
  };
}
