{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    wrapGAppsHook
    pkg-config
  ];
  shellHook = ''
    echo ""
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:/usr/local/share:/usr/share:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  '';
  buildInputs = [
    rustup
    udev
    alsa-lib
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr # To use the x11 feature
    libxkbcommon
    wayland # To use the wayland feature
    cairo
    gtk3
    glib
    gsettings-desktop-schemas
    lld
    trunk
    wasm-bindgen-cli
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}
