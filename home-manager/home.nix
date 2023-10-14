{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "manan";
  home.homeDirectory = "/home/manan";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs; [
      dotnet-sdk
      nodejs_20
      nodePackages.prettier
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodePackages.volar
      nodePackages.svelte-language-server
      nodePackages.bash-language-server
      tailwindcss
      csharp-ls
      lua-language-server
      rnix-lsp

      jq
      socat
      swww
      sway-contrib.grimshot
      libnotify
      eww-wayland
      spotify
      chromium
      rustup
      aseprite
      godot_4
      (blender.override {
        cudaSupport = true;
      })
      pureref
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
      source = ../nvim;
      recursive = true;
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/manan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
}
