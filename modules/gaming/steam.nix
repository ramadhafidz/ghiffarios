{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam

    # 32-bit libraries required by Steam and many games
    lib32zlib
    lib32ncurses5
    lib32libpulse
    lib32libxkbcommon
    lib32mesa
    lib32libdrm
    lib32vulkan

    # X11 libraries needed by Steam
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libXrender
    xorg.libXinerama
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXft
    xorg.libXext

    # Additional graphics libraries
    libdrm
    libglvnd
    vulkan-tools
    vulkan-loader
  ];
}