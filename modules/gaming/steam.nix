{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam

    # Wine for running Windows games (Genshin Impact, etc.)
    wine

    # Additional Wine tools
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

  # Steam configuration
  programs.steam = {
    enable = true;
    gamescopeSupport = true;
    remoteDesktopSupport = true;
  };
}