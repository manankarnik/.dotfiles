# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, lib, config, pkgs, ... }:
let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
      '';
  };

in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelModules = [ "v4l2loopback-dc" "snd-aloop" ];

  # Define your hostname.
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };

    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "delete-older-than 7d";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.manan = {
    isNormalUser = true;
    description = "Manan Karnik";
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      configure-gtk
      glib
      grim
      slurp
      wget
      gcc
      jq
      socat
      libnotify
      ripgrep
      trash-cli
      kitty
      wl-clipboard
      pamixer
      pulseaudio
      pavucontrol
    ];
    # Force wayland on electron apps
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  programs = {
    dconf.enable = true;
    thunar.enable = true;
    fish.enable = true;
    starship.enable = true;
    git.enable = true;
    adb.enable = true;
  };

  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    desktopManager.xterm.enable = false;
  };

  users.defaultUserShell = pkgs.fish;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs;
    [
      vistafonts
      liberation_ttf
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "FiraCode" ];
      })
    ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.x11 = true;
  users.extraGroups.vboxusers.members = [ "manan" ];

  services.xserver.videoDrivers = [ "xf86-video-intel" ];
  #   # Load nvidia driver for Xorg and Wayland
  #   services.xserver.videoDrivers = [ "nvidia" ];
  # 
  #   hardware.nvidia = {
  #     # Modesetting is required.
  #     modesetting.enable = true;
  # 
  #     # Enable the Nvidia settings menu,
  #     # accessible via `nvidia-settings`.
  #     nvidiaSettings = true;
  # 
  #     # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #     package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
