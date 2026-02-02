# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "roxysimp"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "8.8.8.8" "1.1.1.1" ];
  #services.iwd.enable = true;
  hardware.enableAllFirmware = true;
  boot.kernelModules = ["tun" "mt7921e" ];
  hardware.firmware = with pkgs; [ linux-firmware ];  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    options = "win_space_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kelpie = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "kelpie";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    iwd
    kitty
    pciutils
    usbutils
    waybar
    dunst
    wofi
    networkmanagerapplet
    firefox
    alacritty
    telegram-desktop
    vscode
    neovim
    spotify
    vesktop
    steam
    xfce.thunar
    asusctl
    supergfxctl
    vanilla-dmz
    lxappearance        # простая утилита для выбора GTK-тем
    adwaita-icon-theme  # дефолтная иконка
    papirus-icon-theme  # красивая современная
    arc-theme           # популярная GTK-тема
    nix-bash-completions
    linux-wallpaperengine
    mpvpaper    
    gcc
    hyprshot
    libnotify
    nwg-look
    open-sans
    unzip
    v2rayn
    xray
    sing-box

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:
   networking.firewall.allowedTCPPorts = [ 2017 ];
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  nix.settings.substituters = [
  "https://cache.nixos.org/"
  "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7Z8t1/WM0RkB3yXqa9LN3A="
  ];
  # Enable asusctl service
  services.asusd = {
    enable = true;
    enableUserService = true; # Enable user service for user-specific settings
  }; 
  swapDevices = [
    {
      device = "/var/lib/swapfile";
    }
  ];
boot.kernelParams = [
  "resume=UUID=c3a76e86-51e0-4130-a9cb-cf1a39eac0c8"
];
  fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.jetbrains-mono
];
environment.variables = {
  GTK_THEME = "Arc-Dark";
};
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
};
programs.bash.completion.enable = true;
services.xserver.videoDrivers = ["amdgpu" ];
hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = true;         # управление питанием
  powerManagement.finegrained = true;    # более агрессивное энергосбережение
  open = true;
  prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:65:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
};
  # Включить TUN режим для NekoRay
  programs.nekoray.tunMode.enable = true;
  
 

}
