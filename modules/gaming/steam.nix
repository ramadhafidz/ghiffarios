{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam

    # DWProton for anime games (Genshin Impact, etc.)
    dwproton-bin

    # Wine for running Windows games
    wine
    winetricks
    protonup-qt

    # X11 libraries needed by Steam
    libXcursor
    libXrandr
    libXi
    libXrender
    libXinerama
    libXcomposite
    libXdamage
    libXfixes
    libXft
    libXext

    # Additional graphics libraries
    libdrm
    libglvnd
    vulkan-tools
    vulkan-loader
  ];
}